for i in {1..9}; do
  vm_name=$(printf "rhocp1-worker-%d" $i)
  disk_path=$(printf "/home/images/rhocp1-worker-%d_1.img" $i)
  
  virsh detach-disk "$vm_name" "$disk_path" --config --live
done
