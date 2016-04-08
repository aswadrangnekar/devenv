#!/usr/bin/env bash

IP_ADDRESS="$1"

# SHARED_DIR=/opt
# STACK=/opt/stack

echo -e "**** Setup sn-Openstack + Rally ***"
git clone https://github.com/openstack-dev/devstack.git
# git clone https://github.com/openstack/rally
# Copy required files to devstack
# cp rally/contrib/devstack/lib/rally devstack/lib/
# cp rally/contrib/devstack/extras.d/70-rally.sh devstack/extras.d/

# Set-up local.conf
cd devstack
cp samples/local.conf ./
echo "RECLONE=yes" >> local.conf
# echo "GIT_BASE=http://git.openstack.org" >> local.conf
# echo "enable_service rally" >> local.conf

# stack
./stack.sh

echo "**** DONE ****"