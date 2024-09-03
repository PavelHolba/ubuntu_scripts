#!/bin/bash

set -e

# Ensure repositories are up-to-date
echo -e "\n## apt-get update - starting ##\n"
sudo apt-get update
echo -e "\n## apt-get update - done ##\n"

# Install debian packages for dependencies
echo -e "\n## installation of dependencies - starting##\n"
sudo apt-get install -y \
    build-essential \
    libseccomp-dev \
    pkg-config \
    uidmap \
    squashfs-tools \
    fakeroot \
    cryptsetup \
    tzdata \
    dh-apparmor \
    curl wget git
echo -e "\n## installation of dependencies - done ##\n"

#sudo rm -rf /usr/local/go
#https://go.dev/dl/go1.23.0.linux-amd64.tar.gz


export GOVERSION=1.23.0 OS=linux ARCH=amd64  # change this as you need
echo -e "\n## installation of go${GOVERSION}.${OS}-${ARCH} - starting ##\n"
wget -O /tmp/go${GOVERSION}.${OS}-${ARCH}.tar.gz \
  https://go.dev/dl/go${GOVERSION}.${OS}-${ARCH}.tar.gz
sudo tar -C /usr/local -xzf /tmp/go${GOVERSION}.${OS}-${ARCH}.tar.gz
echo -e "\n## installation of go${GOVERSION}.${OS}-${ARCH} - done ##\n"

echo -e "\n## add /usr/local/go/bin to the PATH - starting ##\n"
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc #apptainer.sh: 29: source: not found ???
echo -e "\n## add /usr/local/go/bin to the PATH - done ##\n"

export APPTAINERVERSION=1.3.3
echo -e "\n## cloning apptainer v${APPTAINERVERSION} repo - starting ##\n"
git clone https://github.com/apptainer/apptainer.git
cd apptainer
#git checkout v1.3.3
git checkout v${APPTAINERVERSION}
echo -e "\n## cloning apptainer v${APPTAINERVERSION} repo - done ##\n"

echo -e "\n## building of apptainer v${APPTAINERVERSION} - starting ##\n"
./mconfig
cd $(/bin/pwd)/builddir
make
sudo make install
echo -e "\n## building of apptainer v${APPTAINERVERSION} - done ##\n"
