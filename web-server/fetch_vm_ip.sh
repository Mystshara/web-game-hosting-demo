#!/bin/bash
set -e

#########################################
# 🔍 fetch_vm_ip.sh - Demo-safe version
# ---------------------------------------
# Description:
#   Retrieves the IP address of a Proxmox VM
#   via the Proxmox Guest Agent using SSH.
#
# Usage:
#   ./fetch_vm_ip.sh <VMID> <PROXMOX_HOST> <SSH_KEY_PATH>
#
# Example:
#   ./fetch_vm_ip.sh 101 demo-proxmox.local ~/.ssh/id_ed25519
#########################################

VMID=$1
PROXMOX_IP=$2
SSH_KEY=$3

# 🧠 Query the Proxmox guest agent for network interfaces
INTERFACES=$(ssh -i "$SSH_KEY" -o StrictHostKeyChecking=no root@"$PROXMOX_IP" \
  "qm guest cmd $VMID network-get-interfaces")

# 🌐 Extract IPv4 address from 'eth1' (adjust interface name if needed)
IP=$(echo "$INTERFACES" | jq -r \
  '.[] | select(.name=="eth1") | .["ip-addresses"][] | select(.["ip-address-type"]=="ipv4") | .["ip-address"]' \
  | grep "^192.168.1")

# 📤 Output as JSON for Terraform external data source
echo "{\"ip_address\": \"$IP\"}"
