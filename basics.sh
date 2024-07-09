#!/bin/bash

# Exit immediately if any command fails
set -e

# Clear the terminal screen for clean output
clear

# Print a header indicating the start of the provisioning routine
echo
echo "## Provisioning New Ubuntu Linux Server (Basic) ##"
echo

# Update package lists
sudo apt-get update

# Perform distribution upgrade for handling changes in dependencies
sudo apt-get dist-upgrade -y

# Upgrade installed packages
sudo apt-get upgrade -y

# Install essential network utilities
sudo apt-get install -y net-tools

# Install unpacking tool
sudo apt install bzip2

# Fix permissions to ssh key
chmod 600 .ssh/id_rsa
chmod 644 .ssh/id_rsa.pub


# Print a message indicating the completion of the provisioning routine
echo
echo "## Provisioning Completed Successfully ##"
echo
