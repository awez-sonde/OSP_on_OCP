# Network to attach
NETWORK="osp_net_trunk"
# Target VMs
WORKER_PREFIX="ocp-worker"
# VM count (from 0 to 9)
START=0
END=9

echo "Attaching $NETWORK to VMs $WORKER_PREFIX-$START to $WORKER_PREFIX-$END"

for i in $(seq $START $END); do
    VM_NAME="${WORKER_PREFIX}-${i}"
    MAC_ADDR=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/:$//')
    
    echo "Attaching network $NETWORK to $VM_NAME with MAC $MAC_ADDR"

    virsh attach-interface --domain "$VM_NAME" \
        --type network \
        --source "$NETWORK" \
        --model virtio \
        --mac "$MAC_ADDR" \
        --config --live

    if [ $? -eq 0 ]; then
        echo "Successfully attached $NETWORK to $VM_NAME"
    else
        echo "Failed to attach $NETWORK to $VM_NAME"
    fi
done
