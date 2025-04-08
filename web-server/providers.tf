##############################
# 🔧 Terraform Required Providers (Demo)
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
  skip_tls_verify = true  # For demo/testing only
}

##############################
# 🖥️ Proxmox Provider (Redacted access)
##############################

provider "proxmox" {
  pm_api_url      = "https://demo-proxmox.local:8006/api2/json"  # Placeholder URL
  pm_user         = "demo-user@pam"                              # Safe placeholder user
  pm_password     = "changeme"                                   # 🚫 DO NOT use real creds
  pm_tls_insecure = true                                         # Accept insecure demo TLS
}
