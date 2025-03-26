#!/bin/bash

oc create secret generic dataplane-ansible-ssh-private-key-secret \
--save-config \
--dry-run=client \
--from-file=ssh-privatekey=/root/.ssh/id_rsa \
--from-file=ssh-publickey=/root/.ssh/id_rsa.pub \
--from-file=authorized_keys=/root/.ssh/id_rsa.pub -n openstack \
-o yaml | oc apply -f -
