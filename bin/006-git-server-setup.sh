#!/bin/bash
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- setup the git server
#-------------------------------------------------------------------------------------
umask 0077


#-------------------------------------------------------------------------------------
touch /I-need-to-know-where-I-am-1
mkdir -p /etc/skel/.ssh
cd /etc/skel/.ssh
wget http://lifepod13/ssh-pubkeys/authorized_keys
touch from-script-006-git-server-setup.sh

#-------------------------------------------------------------------------------------
#  -- https://github.com/alghanmi/ubuntu-desktop_setup/wiki/Git-Local-Repository-Setup-Guide
#  -- --gecos GECOS 
umask 0057
touch /home/before
adduser --home /var/git --disabled-password --shell /usr/bin/git-shell --gecos "git manager,,,utility" git
touch /home/after
cp -r /usr/share/doc/git/contrib/git-shell-commands ~git/  # ** check expansion of ~git
usermod -a -G git passwd.username
chmod g+w ~git
touch ~git/I-touched-this

#-------------------------------------------------------------------------------------
cd ~git
cp -pr /mnt/git/cdrom2/* ~git
chown -R git:git .

touch from-in-target  #  /from-in-target
chown git from-in-target
chgrp aubrey from-in-target

#xterm -title git

