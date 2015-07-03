#!/usr/bin/env bash

echo -e "**** Update os packages ***"
apt-get update
apt-get install -y git tig vim

echo "**** Bootstrap DONE ****"