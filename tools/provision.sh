#!/usr/bin/env bash

IP_ADDRESS="$1"

SHARED_DIR=/opt
STACK=/opt/stack

echo -e "**** Update os packages ***"
apt-get update
echo "**** DONE ****"