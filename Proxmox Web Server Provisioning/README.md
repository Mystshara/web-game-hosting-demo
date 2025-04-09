# 🖥️ Web Server Provisioning (Demo)

[![](https://img.shields.io/badge/status-Demo--Only-informational?style=flat-square)](#)

This is a **demo-safe** Terraform module that provisions a web server VM using Proxmox and HashiCorp Vault. It simulates dynamic IP retrieval and secure configuration patterns.

---

## 📦 Overview

- **Provisioning**: Proxmox QEMU VMs via `terraform-provider-proxmox`
- **Secrets**: Mocked Vault-based secret integration (addresses, tokens, keys)
- **Dynamic IPs**: Uses `fetch_vm_ip.sh` to grab the IP post-deploy
- **K8s-Ready**: Prepped for controller and worker VM creation with cloud-init

---

## 📂 File Structure

```plaintext
web-server/
├── main.tf              # Resource definitions for controller & workers
├── variables.tf         # Input vars: Vault address, worker count, etc.
├── outputs.tf           # Output IPs for integration with other modules
├── shared-provider.tf   # Vault & Proxmox providers (demo-safe)
├── fetch_vm_ip.sh       # Script to retrieve VM IP via guest agent
├── terraform.tfvars     # (Optional) Sample input values for testing
└── README.md            # You’re reading it!
