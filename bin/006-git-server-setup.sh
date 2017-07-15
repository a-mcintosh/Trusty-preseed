#!/bin/sh
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- setup the git server
#-------------------------------------------------------------------------------------
umask 0077
mkdir -p /etc/skel/.ssh
cd /etc/skel/.ssh
wget http://lifepod13/ssh-pubkeys/authorized_keys


#-------------------------------------------------------------------------------------
#  -- --gecos GECOS 
adduser --home /var/git --disabled-password --shell /usr/bin/git-shell --gecos "git manager,,,utility account" git


#-------------------------------------------------------------------------------------

