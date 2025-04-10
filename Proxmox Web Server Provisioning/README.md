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

## 🧠 Demo Mode Toggle

This module supports a dynamic `demo_mode` flag for safely switching between mock infrastructure and real Vault-backed secrets.

### 🔐 What It Does

| `demo_mode` | Behavior |
|-------------|----------|
| `true` *(default)*  | Safe for public sharing: demo secrets, mock SSH keys, fake Proxmox host |
| `false`     | Secure deployment: pulls real secrets from Vault, connects to live infrastructure |

### ✅ Benefits

- Keeps your repo **public-safe**
- Shows real-world Vault logic without exposing anything
- Allows collaborators to test or plug in their own secrets later

---

## 🧱 How It Works

Each `.tf` file is updated to honor the `demo_mode` setting:

| File               | Changes Implemented |
|--------------------|---------------------|
| `main.tf`          | Injects real or mock `ciuser`, `cipassword`, and SSH key |
| `variables.tf`     | Adds `demo_mode`, `proxmox_user`, and `proxmox_password` with safe defaults |
| `providers.tf`     | Switches Proxmox provider block between demo endpoint and real values |
| `terraform.tfvars` | Sample config with `demo_mode = true` |
| `fetch_vm_ip.sh`   | No change — works in both modes |

---

### 📌 terraform.tfvars Sample

```hcl
# Enable demo mode: uses mock values instead of real Vault secrets
demo_mode = true

# Vault configuration (ignored in demo mode)
vault_addr  = "https://demo-vault.local:8200"
vault_token = "demo-token"

# Number of Kubernetes worker nodes to provision in the demo
worker_count = 2
