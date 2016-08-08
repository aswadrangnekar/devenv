#!/usr/bin/env bash

echo -e "**** Install Ansible ***"
apt-get install -y software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get install -y ansible

echo "**** Ansible DONE ****"