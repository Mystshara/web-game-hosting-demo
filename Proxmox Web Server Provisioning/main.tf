##############################
# 🧠 Local Values (Demo-aware Upgrade)
# Updated to support dynamic toggle using `demo_mode`
##############################

locals {
  # 👇 Switches between hardcoded demo and secure Vault references
  proxmox_host = var.demo_mode ? "demo-proxmox.local" : data.vault_generic_secret.proxmox_config[0].data["host"]
  ssh_key_path = var.demo_mode ? "~/.ssh/id_ed25519" : data.vault_generic_secret.proxmox_config[0].data["ssh_key_path"]
  ssh_user     = var.demo_mode ? "ubuntu" : data.vault_generic_secret.proxmox_config[0].data["ssh_user"]
  vm_password  = var.demo_mode ? "changeme" : data.vault_generic_secret.proxmox_config[0].data["vm_password"]
  ssh_pub_key  = var.demo_mode ? "ssh-ed25519 AAAAC3MocKedDemOOMOkey==" : data.vault_generic_secret.proxmox_config[0].data["id_ssh_pub"]
}

##############################
# 🔐 Vault Secrets (conditionally loaded when demo_mode = false)
##############################

data "vault_generic_secret" "proxmox_config" {
  count = var.demo_mode ? 0 : 1
  path  = "secret/data/proxmox-config"
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
  ciuser     = local.ssh_user
  cipassword = local.vm_password

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
  # replaced
  ciuser     = local.ssh_user
  cipassword = local.vm_password

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
# 🔐 Optional: Simulated Vault Output

# Only simulate Vault storage when demo_mode is on

##############################

resource "vault_kv_secret_v2" "controller_ip" {
  count = var.demo_mode ? 1 : 0
  mount = "kv"
  name  = "ips/k8s-controller"

  data_json = jsonencode({
    ip_address = data.external.controller_ip.result["ip_address"]
  })
}
