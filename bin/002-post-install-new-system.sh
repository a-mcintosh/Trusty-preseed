#!/bin/sh
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- Some configuration for the new virtual machine, invoked at the end of 
#  -- preseed/iounote.seed
#  --
#  -- rcp ubuntu@2001:470:b8ac:0:44c4:9dea:d631:db1d:~/CD-addons/1492966260/shop-jigs/projects/post-install-new-system.sh
#-------------------------------------------------------------------------------------



#-------------------------------------------------------------------------------------
sudo chown -R 1000:1000 ~aubrey/.
#-------------------------------------------------------------------------------------

echo "export EPOCH=\`date '+%s'\`" >> ~aubrey/.profile
echo mv .bash_history .bash_history-'$EPOCH' >> ~aubrey/.profile
echo "touch .bash_history" >> ~aubrey/.profile

#-------------------------------------------------------------------------------------
sudo sed -i "s/ubuntu/iounote/g" /etc/hostname
sudo sed -i "s/ubuntu/iounote/g" /etc/hosts

#-------------------------------------------------------------------------------------
#  -- the apt proxy is already set-up during the install, /etc/apt/apt.conf, 
#  -- get openssh-server; load backdoor pass (authorized_keys) from web server
#  -- close off password login
#-------------------------------------------------------------------------------------

sudo apt-get update
sudo apt-get install openssh-server ntp git
sudo sed -i 's|[#]*PasswordAuthentication yes|PasswordAuthentication no|g' /etc/ssh/sshd_config
sudo service ssh restart

#-------------------------------------------------------------------------------------
#  -- make reachable at known address.  Coordinated with DNS server.
#-------------------------------------------------------------------------------------

sudo sed -i "/^exit 0$/iip addr add 2001:470:b8ac::2017:402/64 dev eth0" /etc/rc.local
sudo sed -i "/^exit 0$/iip addr add 2001:470:b8ac::1:6/64 dev eth0" /etc/rc.local
ssh-keygen -N "This is not the real pass-phrase." -f ~aubrey/.ssh/id_rsa
(cd ~aubrey/.ssh
  wget http://lifepod13/ssh-pubkeys/authorized_keys
)


#-------------------------------------------------------------------------------------

