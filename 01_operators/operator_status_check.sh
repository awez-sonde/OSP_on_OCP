#!/bin/bash
#
watch -n3 "oc get csv,sub -n openshift-nmstate && oc get csv,sub -n metallb-system && oc get csv,sub -n openstack-operators"

#for project in metallb-system openshift-nmstate openstack-operators cert-manager-operator ; do oc get csv -n  $project ; done
