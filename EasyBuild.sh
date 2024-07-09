#!/bin/bash

# Exit immediately if any command fails
set -e

echo
echo "## Installing EasyBuild ##"
echo

# install pip first
sudo apt install python3-pip

# install EasyBuild to temporary location
export EB_TMPDIR=/tmp/$USER/eb_tmp
python3.10 -m pip install --ignore-installed --prefix $EB_TMPDIR easybuild

# set PATHS and instal easybuild using easybuild
export EB_TMPDIR=/tmp/$USER/eb_tmp
export PATH=$EB_TMPDIR/local/bin:$PATH
export PYTHONPATH=$EB_TMPDIR/local/lib/python3.6/dist-packages:$PYTHONPATH
export EB_PYTHON=python3.6
eb --install-latest-eb-release --prefix $HOME/easybuild

echo
echo "## EasyBuild should be installed ##"
echo