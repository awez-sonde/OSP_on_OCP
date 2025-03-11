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



<img width="1840" alt="image" src="https://github.com/user-attachments/assets/1581b5e4-0b84-409b-8508-03190d8cb6de" />

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


<img width="1855" alt="image" src="https://github.com/user-attachments/assets/210266bd-e758-416d-893b-8c476e368e50" />

#### Master Nodes

* Master nodes require just one NIC as they are only connected to one flat OCP network

#### Worker Nodes

* Two NIC's are required here.
* One for OCP flat network and another for OSP services( Flat + VLAN ) networks

#### Compute Nodes

* Three NIC's are required here
* One for OCP flat , another for OSP services( Flat +VLAN) and one for external flat network.
