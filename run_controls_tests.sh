#!/bin/bash
curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec
cd /tmp/test/integration/default
inspec detect
inspec check /tmp/packer-chef-solo/cookbooks-0/kindlyops-base/test/integration

