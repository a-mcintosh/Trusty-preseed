#!/bin/bash
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- make iounote ls
#  --s
#-------------------------------------------------------------------------------------


#  patches to be back-ported to the installed environment
# -- none --


#  -- a diagnostic -- reveals that libdb5.3 is installed
dpkg -l 'libdb*' | grep Berkeley


#  install packages used for both libdb4.8 build and libdb5.1 build
apt-get -y install libboost-all-dev build-essential libssl-dev  \
 libboost-all-dev  qt4-qmake libqt4-dev  git-core ntp \
 libqrencode-dev libboost-all-dev  libminiupnpc-dev \
 software-properties-common


#  ! This ignores warnings to use libdb4.8 !
#apt-get -y install  libdb5.1++-dev \
# libdb5.1 libdb5.1-dev


#  make IOUnote on top of new installed machine.
#  -- https://askubuntu.com/questions/393289/how-to-install-libdb4-8-dev-or-equivalent-on-13-10
#  -- this fails when the system is quarantined.
sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get -y install  libdb4.8-dev libdb4.8++-dev 


#  -- make and execute the client
cd ~passwd.username/opt/coins/iounote

chgrp -R iounote .
chmod -R g+w .

umask 0002
newgrp iounote
qmake USE_QRCODE=1
make clean
touch check-the-owner-and-group-$EPOCH
make


