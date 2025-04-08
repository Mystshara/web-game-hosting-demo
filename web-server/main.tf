##############################
# 🧠 2. Local Values (Demo-safe)
##############################

locals {
  proxmox_host = "demo-proxmox.local"         # placeholder
  ssh_key_path = "~/.ssh/id_ed25519"          # demo key path
  ssh_user     = "ubuntu"                     # typical demo user
}

##################################
# Kubernetes Master VM (Controller)
##################################

resource "proxmox_vm_qemu" "controller" {
  name        = "k8s-controller-01"
  target_node = "proxmox-node-1"              # placeholder
  clone       = "k8s-controller-template"
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"
  os_type     = "cloud-init"

  memory  = 4096
  sockets = 1
  cores   = 2
  vcpus   = 2
  cpu_type = "host"

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  network {
    id     = 1
    model  = "virtio"
    bridge = "vmbr1"
  }

  disk {
    slot     = "scsi0"
    type     = "disk"
    size     = "32G"
    storage  = "local-lvm"
    iothread = true
  }

  disk {
    slot    = "ide2"
    type    = "cloudinit"
    storage = "local-lvm"
    format  = "raw"
  }

  ipconfig0  = "ip=dhcp"
  ipconfig1  = "ip=dhcp"
  ciuser     = "ubuntu"
  cipassword = "changeme"

  sshkeys = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDEMOkeyPlaceHolderKeyForDemo
EOF

  lifecycle {
    ignore_changes = [
      clone,
      scsihw,
      cpu_type,
      memory,
      vcpus,
      cores
    ]
  }
}

##################################
# Kubernetes Worker VMs (Auto-scaled)
##################################

resource "proxmox_vm_qemu" "worker" {
  count       = var.worker_count
  name        = "k8s-worker-${count.index + 1}"
  target_node = "proxmox-node-1"
  clone       = "k8s-worker-template"
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"
  os_type     = "cloud-init"

  memory  = 2048
  sockets = 1
  cores   = 2
  vcpus   = 2
  cpu_type = "host"

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  network {
    id     = 1
    model  = "virtio"
    bridge = "vmbr1"
  }

  disk {
    slot     = "scsi0"
    type     = "disk"
    size     = "32G"
    storage  = "local-lvm"
    iothread = true
  }

  disk {
    slot    = "ide2"
    type    = "cloudinit"
    storage = "local-lvm"
    format  = "raw"
  }

  ipconfig0  = "ip=dhcp"
  ipconfig1  = "ip=dhcp"
  ciuser     = "ubuntu"
  cipassword = "changeme"

  sshkeys = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDEMOkeyPlaceHolderKeyForDemo
EOF

  lifecycle {
    ignore_changes = [
      clone,
      scsihw,
      cpu_type,
      memory,
      vcpus,
      cores
    ]
  }
}

##############################
# 🌐 4. Dynamic IP Fetch (Demo-safe)
##############################

data "external" "controller_ip" {
  program = [
    "${path.module}/fetch_vm_ip.sh",
    proxmox_vm_qemu.controller.vmid,
    local.proxmox_host,
    local.ssh_key_path
  ]
  depends_on = [proxmox_vm_qemu.controller]
}

##############################
# 🔐 5. Simulated Vault Output
##############################

resource "vault_kv_secret_v2" "controller_ip" {
  mount = "kv"
  name  = "ips/k8s-controller"

  data_json = jsonencode({
    ip_address = data.external.controller_ip.result["ip_address"]
  })
}

