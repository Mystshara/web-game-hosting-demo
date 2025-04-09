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
