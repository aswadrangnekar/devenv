#!/usr/bin/env bash

echo -e "**** Python | Install default packages ***"
apt-get install -y python-pip
echo -e "**** Python | Upgrade pip ***"
pip install -U pip