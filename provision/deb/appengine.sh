#!/usr/bin/env bash

echo -e "**** Appengine | setup appengine ***"
# Create an environment variable for the correct distribution
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
# Add the Cloud SDK distribution URI as a package source
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get -y install google-cloud-sdk

sudo apt-get -y install google-cloud-sdk-app-engine-python
sudo apt-get -y install google-cloud-sdk-app-engine-go