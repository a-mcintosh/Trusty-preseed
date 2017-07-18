#!/bin/sh
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#-------------------------------------------------------------------------------------
cp -pr /cdrom/bin/ /tmp/
chmod -R go=,u=rw  /tmp/bin/.ssh
chmod        u=rwx /tmp/bin/.ssh
ls -laR /tmp/bin

sed -i s/passwd.username/$(debconf-get passwd/username)/g /tmp/bin/*.sh
logger -i "$(debconf-get passwd/username)"
logger -i "$(debconf-get netcfg/hostname)"
logger -i "$(debconf-get netcfg/get_domain)"
logger -i "$(debconf-get netcfg/choose_interface)"
#ls -laR /usr/lib/ubiquity
export DISPLAY=:0.0

