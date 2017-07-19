#!/bin/sh
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#-------------------------------------------------------------------------------------
cp -pr /cdrom/bin/ /tmp/
chmod -R go=,u=rw  /tmp/bin/.ssh
chmod        u=rwx /tmp/bin/.ssh
ls -laR /tmp/bin

sed -i s/passwd.username/$(debconf-get passwd/username)/g /tmp/bin/*.sh
sed -i s/ssh.passphrase/$(debconf-get ssh.passphrase)/g /tmp/bin/*.sh
which ssh-keygen
which dig
nslookup -type=ANY -domain=quarantine.vima.austin.tx.us -ALL lifepod13
nslookup -type=ANY -domain=vima.austin.tx.us -ALL lifepod13
cat /etc/resolv.conf
logger -i "$(debconf-get passwd/username)"
logger -i "$(debconf-get netcfg/hostname)"
logger -i "$(debconf-get netcfg/get_domain)"
logger -i "$(debconf-get netcfg/choose_interface)"
#ls -laR /usr/lib/ubiquity
export DISPLAY=:0.0
which xterm

