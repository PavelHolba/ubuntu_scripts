#!/bin/bash

# Exit immediately if any command fails
set -e

echo
echo "## Installing Lmod ##"
echo

# we first need to repair /etc/apt/sources.list, uncomment all deb-src lines
sudo sed -i -e "s/^# deb/deb/g" /etc/apt/sources.list
# 24.04 ubuntu changed the location and format, so we may need to run this
sudo sed -i 's/^Types: deb$/Types: deb deb-src/' /etc/apt/sources.list.d/ubuntu.sources

sudo apt update

# install necessary tools
sudo apt install gcc
sudo apt install make

# install necessary dependecies for lmod
sudo apt -y build-dep lmod
lua_ver=$(which lua | xargs realpath -e | xargs basename)
sudo apt -y install lib${lua_ver}-dev tcl-dev

# download Lmod and unpack
wget https://sourceforge.net/projects/lmod/files/Lmod-8.7.tar.bz2
tar xfvj Lmod-8.7.tar.bz2

# compile and install Lmod
cd Lmod-8.7
./configure --prefix=/opt/apps
sudo make install

# 
sudo ln -s /opt/apps/lmod/lmod/init/profile        /etc/profile.d/z00_lmod.sh
sudo ln -s /opt/apps/lmod/lmod/init/cshrc          /etc/profile.d/z00_lmod.csh
# sudo ln -s /opt/apps/lmod/lmod/init/profile.fish   /etc/fish/conf.d/z00_lmod.fish

echo
echo "## Lmod should be installed ##"
echo
