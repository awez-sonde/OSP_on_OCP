# Red Hat Openstack on top of Red Hat Openshift
This repo is about deploying red Hat Openstack services on top of Red Hat Openshift

## Architecture

<img width="910" alt="image" src="https://github.com/user-attachments/assets/a292c38e-a434-4685-ac1d-dbd719c53c36" />



## Network Architecture

### Logical Network Architecture



<img width="1840" alt="image" src="https://github.com/user-attachments/assets/1581b5e4-0b84-409b-8508-03190d8cb6de" />

#### Master Nodes 

* The Master-x nodes (red) represent OpenShift’s control plane.
* These nodes handle API requests, scheduling, and cluster management.

#### Worker Nodes

* The Worker-x nodes (green) serve as OpenShift’s compute layer for running OpenStack services.
* OpenShift schedules and manages OpenStack services like Keystone, Neutron, Nova, etc. across these worker nodes.


#### Compute Nodes

* The Compute-x nodes (blue) represent OpenStack’s hypervisor layer, running on OpenShift-managed infrastructure.
* These nodes handle Nova’s virtual machines (VMs).


### Physical Network Architecture


<img width="1855" alt="image" src="https://github.com/user-attachments/assets/210266bd-e758-416d-893b-8c476e368e50" />
