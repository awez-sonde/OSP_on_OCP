#!/bin/bash

set -e

# List available networks
virsh net-list --all

# Prompt for network
read -p "👉 Enter network to attach to 'worker' VMs: " NET

# Validate network
virsh net-list --all | grep -qw "$NET" || { echo "❌ Network '$NET' not found."; exit 1; }

# Get running worker VMs
VMS=$(virsh list --name | grep worker || true)

[ -z "$VMS" ] && { echo "⚠️ No running 'worker' VMs found."; exit 0; }

for VM in $VMS; do
  echo "🔄 Processing $VM"
  
  virsh domiflist "$VM" | grep -qw "$NET" || \
    virsh attach-interface --domain "$VM" --type network --source "$NET" --model virtio --config --live

  IP=$(virsh domifaddr "$VM" | awk '/ipv4/ {print $4}' | cut -d/ -f1 | head -n1)
  
  if [ -n "$IP" ]; then
    echo "🔐 SSH to $VM ($IP):"
    ssh -o StrictHostKeyChecking=no core@$IP "ip -o link show"
  else
    echo "❌ No IP found for $VM"
  fi
done
