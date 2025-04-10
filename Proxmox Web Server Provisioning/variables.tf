##############################
# 🌐 Variables (Demo-safe)
##############################

variable "vault_addr" {
  description = "Vault address (used for secrets management)"
  type        = string
  default     = "https://demo-vault.local:8200"  # Placeholder address
}

variable "vault_token" {
  description = "Vault token (set via environment variable)"
  type        = string
  default     = ""  # Keep empty for safe demo
}

variable "worker_count" {
  description = "Number of Kubernetes worker nodes to provision"
  type        = number
  default     = 2
}

variable "proxmox_user" {
  description = "Proxmox user (used when demo_mode is false)"
  type        = string
  default     = "" # Leave empty for demo mode
}

variable "proxmox_password" {
  description = "Proxmox password (used when demo_mode is false)"
  type        = string
  default     = "" # Leave empty for demo mode
}

variable "demo_mode" {
  description = "Toggle to use mock demo values instead of real Vault secrets"
  type        = bool
  default     = true
}
