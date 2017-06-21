#!/bin/sh
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  2017-04-24 1493017251  $Id$
#  -- 3nd phase of virtual machine setup
#  -- Prerequisite:  new virtual machine, Ubuntu 14.04.3 installed
#  -- Install minerd, the cpu miner
#-------------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------
#  -- prepare to write in some system directories
sudo chmod o+wt /usr/local/bin
sudo chmod o+wt /usr/local/share/man

#-------------------------------------------------------------------------------------
#  -- load some support packages
sudo apt-get install git automake libcurl4-openssl-dev
#sudo apt-get install curl

#-------------------------------------------------------------------------------------
# -- install minerd
mkdir -p ~/opt/iso/coins/iouscript/sandbox-$EPOCH/iouscript-install
mkdir -p ~/opt/coins; cd ~/opt/coins

#-------------------------------------------------------------------------------------
#git clone http://curl.haxx.se/libcurl
git clone https://github.com/pooler/cpuminer
cd ~/opt/coins/cpuminer
./autogen.sh
./configure CFLAGS="-O3"
make
sudo make install

