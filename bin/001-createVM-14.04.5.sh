#!/bin/sh
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- make a VirtualBox machine, install Ubuntu 14.04.5 LTS (trusty)
#  -- execute from inside the top level $EPOCH directory on the host computer
#-------------------------------------------------------------------------------------
aux=`pwd`
thisEpoch=`basename $aux`; export thisEpoch; echo for epoch $thisEpoch

VBoxManage unregistervm "iounote-$thisEpoch" --delete
VBoxManage createvm --name "iounote-$thisEpoch" --ostype Ubuntu_64 --register
VBoxManage modifyvm "iounote-$thisEpoch" --description "Ubuntu 14.04.5 Environment for IOUnote environment." 
VBoxManage modifyvm "iounote-$thisEpoch" --clipboard bidirectional --memory 1024 --nic1 bridged --vram 10 --bridgeadapter1 eth0 --cableconnected1=off
VBoxManage modifyvm "iounote-$thisEpoch" --nic2 hostonly --hostonlyadapter2 vboxnet1
VBoxManage modifyvm "iounote-$thisEpoch" --vrde on
VBoxManage createhd --filename "/home/amcintosh/VirtualBox VMs/iounote-$thisEpoch/iounote-$thisEpoch.system.vdi" --size 12800
VBoxManage createhd --filename "/home/amcintosh/VirtualBox VMs/iounote-$thisEpoch/iounote-$thisEpoch.projects.vdi" --size 8096
VBoxManage createhd --filename "/home/amcintosh/VirtualBox VMs/iounote-$thisEpoch/iounote-$thisEpoch.blockchains.vdi" --size 20480


#-------------------------------------------------------------------------------------
VBoxManage storagectl "iounote-$thisEpoch" --name "SATA Controller" --add sata --portcount 6
VBoxManage storageattach "iounote-$thisEpoch"  --storagectl "SATA Controller" --port 0 --device 0 --type dvddrive --medium /home/amcintosh/projects/iounote/$thisEpoch/ubuntu-14.04.5-iounote-$thisEpoch-amd64.iso --hotpluggable on

VBoxManage storageattach "iounote-$thisEpoch" --storagectl "SATA Controller" --port 2 --device 0  --type hdd --medium "/home/amcintosh/VirtualBox VMs/iounote-$thisEpoch/iounote-$thisEpoch.system.vdi"
VBoxManage storageattach "iounote-$thisEpoch" --storagectl "SATA Controller" --port 3 --device 0  --type hdd --medium "/home/amcintosh/VirtualBox VMs/iounote-$thisEpoch/iounote-$thisEpoch.projects.vdi"
VBoxManage storageattach "iounote-$thisEpoch" --storagectl "SATA Controller" --port 4 --device 0  --type hdd --medium "/home/amcintosh/VirtualBox VMs/iounote-$thisEpoch/iounote-$thisEpoch.blockchains.vdi"

VBoxManage storageattach "iounote-$thisEpoch"  --storagectl "SATA Controller" --port 6 --device 0 --type dvddrive --medium /usr/share/virtualbox/VBoxGuestAdditions.iso --hotpluggable on
#-------------------------------------------------------------------------------------

echo VBoxManage startvm "iounote-$thisEpoch"
