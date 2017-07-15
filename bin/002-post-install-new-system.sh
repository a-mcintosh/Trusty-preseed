#!/bin/bash
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- Some configuration for the new virtual machine, invoked at the end of 
#  -- preseed/iounote.seed
#  --
#  -- rcp ubuntu@2001:470:b8ac:0:44c4:9dea:d631:db1d:~/CD-addons/1492966260/shop-jigs/projects/post-install-new-system.sh
#-------------------------------------------------------------------------------------



#-------------------------------------------------------------------------------------
cat <<EOF >> ~passwd.username/.profile

export EPOCH=\`date '+%s'\`
touch .bash_history-\$EPOCH
if [ -e .bash_history ]; then
  rm .bash_history 
fi
ln  .bash_history-\$EPOCH .bash_history
EOF


#-------------------------------------------------------------------------------------
sudo sed -i "s/ubuntu/iounote/g" /etc/hostname
sudo sed -i "s/ubuntu/iounote/g" /etc/hosts

#-------------------------------------------------------------------------------------
#  -- the apt proxy is already set-up during the install, /etc/apt/apt.conf, 
#  -- get openssh-server; load backdoor pass (authorized_keys) from web server
#  -- close off password login
#-------------------------------------------------------------------------------------

apt-get update
apt-get -y install apache2 git-core ntp openssh-server
sed -i 's|[#]*PasswordAuthentication yes|PasswordAuthentication no|g' /etc/ssh/sshd_config
service ssh restart

usermod -a -G www-data passwd.username
chgrp -R www-data ~www-data
chmod g+w ~www-data

#-------------------------------------------------------------------------------------
#  -- make reachable at known address.  Coordinated with DNS server.
#-------------------------------------------------------------------------------------
sed -i "/^exit 0$/iip addr add 2001:470:b8ac::2017:402/64 dev eth0" /etc/rc.local
sed -i "/^exit 0$/iip addr add 2001:470:b8ac::1:6/64 dev eth0" /etc/rc.local

sed -i "/^exit 0$/iip addr add fdbf:946a:5c97:1::6/64 dev eth1" /etc/rc.local

mkdir -p ~passwd.username/opt/iso/{cdrom,tmp}

#-------------------------------------------------------------------------------------
#  -- Autostart a terminal on login
#-------------------------------------------------------------------------------------
mkdir -p ~passwd.username/.config/autostart
cat <<EOF > ~passwd.username/.config/autostart/gnome-terminal.desktop
[Desktop Entry]
Type=Application
Exec=gnome-terminal --geometry 80x25+800+800
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=Terminal
Name=Terminal
Comment[en_US]=I always use a terminal
Comment=I always use a terminal
EOF

#-------------------------------------------------------------------------------------
#  -- Virtual Web Host for IOUnote
#  -- I tried a wild card inside the IPv6 address, no bueno.
#-------------------------------------------------------------------------------------
cat <<EOF > /etc/apache2/sites-available/001-iounote.conf
<VirtualHost [2001:470:b8ac::2017:401]:80>
	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/www-iounote
	ServerName iounote.vima.austin.tx.us
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

cat <<EOF > /etc/apache2/sites-available/002-iounote.conf
<VirtualHost [2001:470:b8ac::2017:402]:80>
	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/www-iounote
	ServerName iounote.vima.austin.tx.us
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

a2ensite 002-iounote.conf


#-------------------------------------------------------------------------------------
#  -- setup multiple .ssh directories
#  -- document where different directories are
#-------------------------------------------------------------------------------------
(  
cd ~
echo `pwd` > ~passwd.username/info.pwd
cd ~root
echo `pwd` >> ~passwd.username/info.pwd
cd ~www-data
echo `pwd` >> ~passwd.username/info.pwd
touch ~passwd.username/I-am-user-$USER
)

#-------------------------------------------------------------------------------------
#  -- set up the first one
#-------------------------------------------------------------------------------------
cp -pr /tmp/bin/ ~passwd.username/bin/
mv ~passwd.username/bin/.ssh ~passwd.username
chmod -R u+w ~passwd.usernamename/.ssh
(
  cd ~passwd.username/.ssh
  chmod 0400 ~passwd.username/.ssh/id_rsa
  wget http://lifepod13/ssh-pubkeys/authorized_keys
  cat id_rsa-*.pub >> authorized_keys
  chmod -R u+r,g-rw,o-rw ~passwd.username/.ssh/

#-------------------------------------------------------------------------------------
#  -- copy it to the two others.
# I can't see ~/.ssh after the install is finished.  However,
# the git clone can't log in without it.
#-------------------------------------------------------------------------------------
  mkdir -p {~,~root}/.ssh
  cp -pr ~passwd.username/.ssh/* ~root/.ssh
  cp -pr ~passwd.username/.ssh/*     ~/.ssh
)

ssh git@iounote.quarantine.vima.austin.tx.us pwd  #force known_hosts update
git clone git@iounote.quarantine.vima.austin.tx.us:www-iounote.git  ~www-data/www-iounote
git clone /cdrom ~passwd.username/opt/iso/Trusty-preseed
# vim: syntax=apache ts=4 sw=4 sts=4 sr noetls 
#-------------------------------------------------------------------------------------
sudo chown -R 1000:1000 ~passwd.username/.
logger -i "Aubrey, why don't I show up in syslog?"


