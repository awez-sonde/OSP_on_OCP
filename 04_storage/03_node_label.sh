for node in `oc get nodes -o name | grep -i worker ` ; do oc label $node cluster.ocs.openshift.io/openshift-storage='' ; done
