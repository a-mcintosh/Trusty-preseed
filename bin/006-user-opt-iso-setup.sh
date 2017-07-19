#!/bin/sh
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- setup the opt directory
#-------------------------------------------------------------------------------------
umask 0067

#-------------------------------------------------------------------------------------
cp -pr /mnt/username/opt/ /home/passwd.username/
chown -R passwd.username:passwd.username ~passwd.username
#xterm -title opt

