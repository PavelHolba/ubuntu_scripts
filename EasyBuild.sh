#!/bin/bash

# Exit immediately if any command fails
set -e

echo
echo "## Installing EasyBuild ##"
echo

# install pip first
sudo apt install -y python3-pip

# install EasyBuild to temporary location
export EB_TMPDIR=/tmp/$USER/eb_tmp
python3.10 -m pip install --ignore-installed --prefix $EB_TMPDIR easybuild

# set PATHS and instal easybuild using easybuild
export PATH=$EB_TMPDIR/local/bin:$PATH
export PYTHONPATH=$EB_TMPDIR/local/lib/python3.10/dist-packages:$PYTHONPATH
export EB_PYTHON=python3.10

eb --install-latest-eb-release --prefix $HOME/easybuild

# lastly we need to say Lmod, where he can find it
# module use /home/hol0598/easybuild/modules/all/
echo '

# Set up Lmod environment variables
export MODULESHOME=/opt/apps/lmod/lmod
source $MODULESHOME/init/profile' >> ~/.profile

echo '

# Lmod settings
export MODULESHOME=/opt/apps/lmod/lmod
export MODULEPATH=$HOME/easybuild/modules/all:/opt/apps/modulefiles/Linux:/opt/apps/modulefiles/Core:/opt/apps/lmod/lmod/modulefiles/Core
source $MODULESHOME/init/bash
' >> ~/.bashrc
# module load EasyBuild

echo
echo "## EasyBuild should be installed ##"
echo