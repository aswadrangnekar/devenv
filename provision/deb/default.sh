#!/usr/bin/env bash

echo -e "**** Default | Update os packages ***"
apt-get update
echo -e "**** Default | Install default packages ***"
apt-get install -y git tig vim
mkdir /home/vagrant/code