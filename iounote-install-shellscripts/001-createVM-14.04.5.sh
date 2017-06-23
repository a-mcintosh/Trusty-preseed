#!/bin/sh
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- make a VirtualBox machine
#  -- execute from inside the $EPOCH directory
#-------------------------------------------------------------------------------------
aux=`pwd`
thisEpoch=`basename $aux`; export thisEpoch; echo for epoch $thisEpoch

VBoxManage createvm --name "coins-$thisEpoch" --ostype Ubuntu_64 --register
VBoxManage modifyvm "coins-$thisEpoch" --description "Environment to create an coins Ubuntu install CD based on 14.04.5." 
VBoxManage modifyvm "coins-$thisEpoch" --clipboard bidirectional --memory 1024 --nic1 bridged --vram 10 --bridgeadapter1 eth0
VBoxManage modifyvm "coins-$thisEpoch" --vrde on
VBoxManage createhd --filename "/home/amcintosh/VirtualBox VMs/coins-$thisEpoch/coins-$thisEpoch.system.vdi" --size 12800
VBoxManage createhd --filename "/home/amcintosh/VirtualBox VMs/coins-$thisEpoch/coins-$thisEpoch.projects.vdi" --size 8096
VBoxManage createhd --filename "/home/amcintosh/VirtualBox VMs/coins-$thisEpoch/coins-$thisEpoch.blockchains.vdi" --size 20480


#-------------------------------------------------------------------------------------
VBoxManage storagectl "coins-$thisEpoch" --name "SATA Controller" --add sata --portcount 6
VBoxManage storageattach "coins-$thisEpoch"  --storagectl "SATA Controller" --port 0 --device 0 --type dvddrive --medium /home/amcintosh/projects/coins/$thisEpoch/ubuntu-14.04.5-coins-$thisEpoch-amd64.iso --hotpluggable on

VBoxManage storageattach "coins-$thisEpoch" --storagectl "SATA Controller" --port 2 --device 0  --type hdd --medium "/home/amcintosh/VirtualBox VMs/coins-$thisEpoch/coins-$thisEpoch.system.vdi"
VBoxManage storageattach "coins-$thisEpoch" --storagectl "SATA Controller" --port 3 --device 0  --type hdd --medium "/home/amcintosh/VirtualBox VMs/coins-$thisEpoch/coins-$thisEpoch.projects.vdi"
VBoxManage storageattach "coins-$thisEpoch" --storagectl "SATA Controller" --port 4 --device 0  --type hdd --medium "/home/amcintosh/VirtualBox VMs/coins-$thisEpoch/coins-$thisEpoch.blockchains.vdi"

VBoxManage storageattach "coins-$thisEpoch"  --storagectl "SATA Controller" --port 7 --device 0 --type dvddrive --medium /usr/share/virtualbox/VBoxGuestAdditions.iso --hotpluggable on
VBoxManage storageattach "coins-$thisEpoch"  --storagectl "SATA Controller" --port 8 --device 0 --type dvddrive --medium emptydrive --hotpluggable on
#-------------------------------------------------------------------------------------

echo VBoxManage startvm "coins-$thisEpoch"
