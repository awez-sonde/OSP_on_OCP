# Red Hat Openstack on top of Red Hat Openshift
This repo is about deploying red Hat Openstack services on top of Red Hat Openshift

## Architecture

<img width="910" alt="image" src="https://github.com/user-attachments/assets/a292c38e-a434-4685-ac1d-dbd719c53c36" />

This architecture represents an OpenShift cluster running OpenStack services, with all components virtualized on a Red Hat Enterprise Linux 9 (RHEL 9) KVM Host.

🖥️ Virtualized Infrastructure on RHEL 9 KVM
	•	The entire OpenShift and OpenStack deployment is running as Virtual Machines (VMs) on a RHEL 9 KVM host.
	•	The KVM hypervisor provides the underlying compute, storage, and networking resources.

🔴 OpenShift Master Nodes (Control Plane)
	•	3 Master Nodes (master-0, master-1, master-2) are deployed to manage cluster orchestration.
	•	These nodes handle API requests, scheduling, and OpenShift control functions.

🟢 OpenShift Worker Nodes
	•	10 Worker Nodes (worker-0 to worker-9) serve as the compute platform for OpenStack services.
	•	OpenStack control plane components (e.g., Keystone, Neutron, Nova, Cinder) are containerized and run on these worker nodes.

🔵 OpenStack Compute Nodes
	•	2 Compute Nodes (compute-0, compute-1) are dedicated to running OpenStack virtual machines (VMs).
	•	These nodes provide Nova-managed instances (VM workloads) inside OpenStack.
	•	They operate separately from OpenShift’s containerized workloads.

🔗 Networking & Integration


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
