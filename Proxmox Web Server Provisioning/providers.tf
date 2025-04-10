##############################
# 🔧 Terraform Required Providers
##############################

terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc7"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.0.0"
    }
  }
}

##############################
# 🔐 Vault Provider (Safe Demo)
##############################

provider "vault" {
  address         = var.vault_addr
  token           = var.vault_token
  skip_tls_verify = true # For demo/testing only
}

##############################
# 🖥️ Proxmox Provider (Demo-aware Toggle)
##############################

provider "proxmox" {
  pm_api_url      = var.demo_mode ? "http://127.0.0.1:9999/api2/json" : "https://your-proxmox.local:8006/api2/json"
  pm_user         = var.demo_mode ? "demo-user@pam" : var.proxmox_user
  pm_password     = var.demo_mode ? "demo-password" : var.proxmox_password
  pm_tls_insecure = true # 🔐 Set to false in production

  # 📝 Note:
  # In demo_mode, this avoids real API calls and lets you test infrastructure logic without deployment.
}
