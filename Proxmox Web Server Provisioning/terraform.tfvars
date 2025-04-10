##############################
# 🧪 Demo Mode Toggle
##############################

demo_mode = true  # Use mock values and skip real Vault calls


##############################
# 🔐 Vault Settings (Mocked in demo mode)
##############################

vault_addr  = "https://demo-vault.local:8200"  # Safe placeholder for testing
vault_token = "demo-token"                    # Required format, but unused in demo mode


##############################
# 🖥️ Worker Node Count (Adjust as needed)
##############################

worker_count = 2  # Number of Kubernetes workers to spin up
