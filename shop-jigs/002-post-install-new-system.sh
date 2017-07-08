#!/bin/sh
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- 2nd phase of virtual machine setup
#  -- This should all be in preseed when I learn how.
#  --
#  -- rcp ubuntu@2001:470:b8ac:0:44c4:9dea:d631:db1d:~/CD-addons/1492966260/shop-jigs/projects/post-install-new-system.sh
#-------------------------------------------------------------------------------------



#-------------------------------------------------------------------------------------
sudo chown -R `whoami`:`whoami` ~/.
mkdir -p ~/bin; cd ~/bin; chmod u+w,o+wt ~/bin
#-------------------------------------------------------------------------------------

echo "export EPOCH=\`date '+%s'\`" >> ~/.profile
echo mv .bash_history .bash_history-'$EPOCH' >> ~/.profile
echo touch .bash_history >> ~/.profile

#-------------------------------------------------------------------------------------
sudo sed -i "s/ubuntu/iounote/g" /etc/hostname
sudo sed -i "s/ubuntu/iounote/g" /etc/hosts

#-------------------------------------------------------------------------------------
#  -- set up ability to get updates from local apt-ng server, 
#  -- get openssh-server; load backdoor pass (authorized_keys) from web server
#  -- close off password login
#-------------------------------------------------------------------------------------

echo 'Acquire::http { Proxy "http://lifepod13.quarantine.vima.austin.tx.us:3142"; };' > 01proxy
sudo mv 01proxy /etc/apt/apt.conf.d/.
sudo apt-get install openssh-server
sudo sed -i 's|[#]*PasswordAuthentication yes|PasswordAuthentication no|g' /etc/ssh/sshd_config
sudo service ssh restart

#-------------------------------------------------------------------------------------
#  -- make reachable at known address.  Coordinated with DNS server.
#-------------------------------------------------------------------------------------

sudo sed -i "/^exit 0$/iip addr add 2001:470:b8ac::2017:402/64 dev eth0" /etc/rc.local
sudo sed -i "/^exit 0$/iip addr add 2001:470:b8ac::1:6/64 dev eth0" /etc/rc.local
ssh-keygen -N "This is not the real pass-phrase." -f ~/.ssh/id_rsa
(cd ~/.ssh
  wget http://lifepod13/ssh-pubkeys/authorized_keys
)


#-------------------------------------------------------------------------------------
sudo apt-get install ntp git

