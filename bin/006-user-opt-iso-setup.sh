#!/bin/sh
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- setup the opt directory
#-------------------------------------------------------------------------------------
umask 0067

#-------------------------------------------------------------------------------------
cp -pr /mnt/username/opt/ /home/passwd.username/
chmod -R ug+w /home/passwd.username/opt
chown -R passwd.username:passwd.username ~passwd.username
#xterm -title opt

