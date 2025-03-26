#!/bin/bash
#

for project in metallb-system openshift-nmstate openstack-operators cert-manager-operator ; do oc get csv -n  $project ; done
