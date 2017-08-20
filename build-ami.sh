#!/bin/bash

# To update base ami, go to https://cloud-images.ubuntu.com/locator/ec2/
# search `16.04 hvm:ebs-ssd us-east-1`
export PACKER_AMI=ami-80861296 # updated April 30, 2017
export PACKER_OVF=~/.vagrant.d/boxes/bento-VAGRANTSLASH-ubuntu-16.04/2.3.5/virtualbox/box.ovf
random_str=$(cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
export PACKER_COOKBOOKS_DIR=".cookbooks-${random_str}"
berks vendor -b chef/Berksfile $PACKER_COOKBOOKS_DIR
## If you need to ssh into the instance to debug something going wrong, use the -debug flag
# packer will save the private key in the current directory and output the IP info to connect.
#packer build -debug ami.json
packer build ami.json
rm -rf $PACKER_COOKBOOKS_DIR
