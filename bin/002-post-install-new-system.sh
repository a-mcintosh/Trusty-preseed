#!/bin/bash
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- Some configuration for the new virtual machine, invoked at the end of 
#  -- preseed/iounote.seed
#  --
#  -- rcp ubuntu@2001:470:b8ac:0:44c4:9dea:d631:db1d:~/CD-addons/1492966260/shop-jigs/projects/post-install-new-system.sh
#-------------------------------------------------------------------------------------



#-------------------------------------------------------------------------------------
cat <<EOF >> ~aubrey/.profile

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

usermod -a -G www-data aubrey
chgrp -R www-data ~www-data
chmod g+w ~www-data

#-------------------------------------------------------------------------------------
#  -- make reachable at known address.  Coordinated with DNS server.
#-------------------------------------------------------------------------------------
sed -i "/^exit 0$/iip addr add 2001:470:b8ac::2017:402/64 dev eth0" /etc/rc.local
sed -i "/^exit 0$/iip addr add 2001:470:b8ac::1:6/64 dev eth0" /etc/rc.local

sed -i "/^exit 0$/iip addr add fdbf:946a:5c97:1::6/64 dev eth1" /etc/rc.local

mkdir -p ~aubrey/{.ssh,opt/iso/{in,out}}
(
  cd ~aubrey/.ssh
  wget http://lifepod13/ssh-pubkeys/authorized_keys
  cat ../bin/id_rsa-*.pub >> authorized_keys
)

#-------------------------------------------------------------------------------------
#  -- Autostart a terminal on login
#-------------------------------------------------------------------------------------
mkdir -p ~aubrey/.config/autostart
cat <<EOF > ~aubrey/.config/autostart/gnome-terminal.desktop
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
#-------------------------------------------------------------------------------------
cat <<EOF > /etc/apache2/sites-available/001-iounote.conf
<VirtualHost [2001:470:b8ac::2017:402]:80>
	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/www-iounote
	ServerName iounote.vima.austin.tx.us
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

a2ensite 001-iounote.conf
(
cd ~
echo `pwd` > ~aubrey/info.pwd
cd ~root
echo `pwd` >> ~aubrey/info.pwd
cd ~www-data
echo `pwd` >> ~aubrey/info.pwd
ssh-keygen -f ~aubrey/.ssh/id_rsa_rootkey #too force .ssh directory initialization 'I am Groot.'
mv ~aubrey/bin/id_rsa* ~aubrey/.ssh/
chmod 0400 ~aubrey/.ssh/id_rsa
mkdir -p ~root/.ssh
cp -p ~aubrey/.ssh/id_rsa{,.pub} ~root/.ssh
mkdir -p ~/.ssh
cp -p ~aubrey/.ssh/id_rsa{,.pub} ~/.ssh
git clone git@iounote.quarantine.vima.austin.tx.us:www-iounote.git
)

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
#-------------------------------------------------------------------------------------
sudo chown -R 1000:1000 ~aubrey/.
logger -i "Aubrey, this is the end."



