#!/bin/sh
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- setup the opt directory
#-------------------------------------------------------------------------------------
umask 0067
mkdir -p /target/home/passwd.username/opt/


#-------------------------------------------------------------------------------------

mkdir -p /target/mnt/passwd.username/opt
mount /dev/sr3 /target/mnt/passwd.username/opt
cp -pr /target/mnt/passwd.username/opt/ /target/home/passwd.username/
chown -R 1000 /target/home/passwd.username/opt
xterm -title opt

