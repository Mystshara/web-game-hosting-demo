##################################
# Outputs DEMO
##################################

output "controller_ip" {
  value = data.external.controller_ip.result["ip_address"]
}

output "worker_ips" {
  value = [for i in proxmox_vm_qemu.worker : "worker-${i.count.index + 1}-ip"]
}
