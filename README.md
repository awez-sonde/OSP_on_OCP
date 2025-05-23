# Red Hat Openstack on top of Red Hat Openshift
This repo is about deploying red Hat Openstack services on top of Red Hat Openshift

## Architecture

<img width="910" alt="image" src="https://github.com/user-attachments/assets/a292c38e-a434-4685-ac1d-dbd719c53c36" />

This architecture represents an OpenShift cluster running OpenStack services, with all components virtualized on a Red Hat Enterprise Linux 9 (RHEL 9) KVM Host.

#### Virtualized Infrastructure on RHEL 9 KVM

* The entire OpenShift and OpenStack deployment is running as Virtual Machines (VMs) on a RHEL 9 KVM host.
* The KVM hypervisor provides the underlying compute, storage, and networking resources.

#### OpenShift Master Nodes (Control Plane)

* 3 Master Nodes (master-0, master-1, master-2) are deployed to manage cluster orchestration.
* These nodes handle API requests, scheduling, and OpenShift control functions.

#### OpenShift Worker Nodes
* 10 Worker Nodes (worker-0 to worker-9) serve as the compute platform for OpenStack control plane services.
* OpenStack control plane components (e.g., Keystone, Neutron, Nova, Cinder) are containerized and run on these worker nodes.

#### OpenStack Compute Nodes
* 2 Compute Nodes (compute-0, compute-1) are dedicated to running OpenStack virtual machines (VMs).
* These nodes provide Nova-managed instances (VM workloads) inside OpenStack.
* They operate separately from OpenShift’s containerized workloads.




## Network Architecture

### Logical Network Architecture



<img width="1776" alt="image" src="https://github.com/user-attachments/assets/72909811-2666-4b5a-990f-a63a8731304c" />


#### Master Nodes 

* The Master-x nodes (red) are only connected to the OCP machine network as they do not host Openstack services on top of them.This is an example of `Dedicated nodes topology`
* Hosting openstack services on Master nodes are also supported using `Compact topology` but we will not use it in this example.

#### Worker Nodes

* The Worker-x nodes (green) are connected to the OCP network.
* These nodes are also connected to the OSP networks.This is because all the OSP containerized workloads need to communicate to each other via different networks.
* Finally, the external network (optional) is not connected here since this network is used to connect the VM to external environment and VMs within Openstack won't reside on these Worker nodes.


#### Compute Nodes

* The Compute-x nodes (blue) represent OpenStack’s hypervisor layer, running on OpenShift-managed infrastructure.
* These nodes are connected to all the networks.


### Physical Network Architecture


<img width="1833" alt="image" src="https://github.com/user-attachments/assets/1f48f18c-48d6-4965-b621-9132d3074a4c" />


#### Master Nodes

* Master nodes require just one NIC as they are only connected to one flat OCP network

#### Worker Nodes

* Two NIC's are required here.
* One for OCP flat network and another for OSP services( Flat + VLAN ) networks

#### Compute Nodes

* Two NIC's are required here
* One for OSP services( Flat +VLAN) and one for external flat network.


### Network Ranges

| Network Name | VLAN | CIDR | NetConfig <br> allocation range | MetalLB <br> IPAddressPool range | net-attach-def <br> ipam range | OCP worker nncp range |
| -- | -- | -- | -- | -- | -- | -- |
| ctlplane | n/a | 192.168.10.0/24 | 192.168.10.100- <br> 192.168.10.250 | 192.168.10.80- <br> 192.168.10.90 | 192.168.10.30- <br> 192.168.10.70 | 192.168.10.10- <br> 192.168.10.20 |
| external | n/a | 10.0.0.0/24 | 10.0.0.100- <br> 10.0.0.250 | n/a | n/a | n/a |
| internalapi | 20 | 172.17.0.0/24 | 172.17.0.100- <br> 172.17.0.250 |  172.17.0.80- <br> 172.17.0.90 | 172.17.0.30- <br> 172.17.0.70 | 172.17.0.10- <br> 172.17.0.20 |
| tenant | 21 | 172.19.0.0/24 | 172.19.0.100- <br> 172.19.0.250 | n/a | 172.19.0.30- <br> 172.19.0.70 | 172.19.0.10- <br> 172.19.0.20 |
| storage | 22 | 172.18.0.0/24 | 172.18.0.100- <br> 172.18.0.250 | n/a | 172.18.0.30- <br> 172.18.0.70 | 172.18.0.10- <br> 172.18.0.20 |





