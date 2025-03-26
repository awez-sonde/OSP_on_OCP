oc create secret generic subscription-manager \
--from-literal rhc_auth='{"login": {"username": "asonde@redhat.com", "password": "<subscription_manager_password>"}}'

oc create secret generic redhat-registry --from-literal edpm_container_registry_logins='{"registry.redhat.io": {"asonde@redhat.com": "<password>"}}'
