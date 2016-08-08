#!/usr/bin/env bash

echo -e "**** Update os packages ***"
apt-get update
apt-get install -y git tig vim python-pip
pip install -U pip

echo "**** Bootstrap DONE ****"