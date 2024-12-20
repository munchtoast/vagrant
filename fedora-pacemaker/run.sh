#!/bin/bash
# Background: Using "vagrant up" or "vagrant provision" results in a race condition where ordering matters for these playbooks. This script is a workaround that gets everything working.
vagrant destroy -f;

vagrant up --no-provision;
vagrant provision --provision-with shell;
vagrant provision --provision-with init-users;
vagrant provision pc1 --provision-with init-cluster;
vagrant provision pc1 --provision-with test-cluster;
#vagrant provision pc1 --provision-with cleanup;
