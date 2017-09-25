#!/usr/bin/env bash

echo -e "**** Ansible | Install Ansible ***"
apt-get install -y software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get install -y ansible