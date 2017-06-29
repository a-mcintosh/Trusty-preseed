#!/bin/sh
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- make a VirtualBox machine, install Ubuntu 14.04.5 LTS (trusty)
#  -- execute from inside the top level $EPOCH directory on the host computer
#-------------------------------------------------------------------------------------
aux=`pwd`
thisEpoch=`basename $aux`; export thisEpoch; echo for epoch $thisEpoch

VBoxManage createvm --name "iou-$thisEpoch" --ostype Ubuntu_64 --register
VBoxManage modifyvm "iou-$thisEpoch" --description "Ubuntu 14.04.5 Environment for IOUnote environment." 
VBoxManage modifyvm "iou-$thisEpoch" --clipboard bidirectional --memory 1024 --nic1 bridged --vram 10 --bridgeadapter1 eth0 --cableconnected1=off
VBoxManage modifyvm "iou-$thisEpoch" --nic2 hostonly --hostonlyadapter2 vboxnet1
VBoxManage modifyvm "iou-$thisEpoch" --vrde on
VBoxManage createhd --filename "/home/amcintosh/VirtualBox VMs/iou-$thisEpoch/iou-$thisEpoch.system.vdi" --size 12800
VBoxManage createhd --filename "/home/amcintosh/VirtualBox VMs/iou-$thisEpoch/iou-$thisEpoch.projects.vdi" --size 8096
VBoxManage createhd --filename "/home/amcintosh/VirtualBox VMs/iou-$thisEpoch/iou-$thisEpoch.blockchains.vdi" --size 20480


#-------------------------------------------------------------------------------------
VBoxManage storagectl "iou-$thisEpoch" --name "SATA Controller" --add sata --portcount 6
VBoxManage storageattach "iou-$thisEpoch"  --storagectl "SATA Controller" --port 0 --device 0 --type dvddrive --medium /home/amcintosh/projects/iou/$thisEpoch/ubuntu-14.04.5-iou-$thisEpoch-amd64.iso --hotpluggable on

VBoxManage storageattach "iou-$thisEpoch" --storagectl "SATA Controller" --port 2 --device 0  --type hdd --medium "/home/amcintosh/VirtualBox VMs/iou-$thisEpoch/iou-$thisEpoch.system.vdi"
VBoxManage storageattach "iou-$thisEpoch" --storagectl "SATA Controller" --port 3 --device 0  --type hdd --medium "/home/amcintosh/VirtualBox VMs/iou-$thisEpoch/iou-$thisEpoch.projects.vdi"
VBoxManage storageattach "iou-$thisEpoch" --storagectl "SATA Controller" --port 4 --device 0  --type hdd --medium "/home/amcintosh/VirtualBox VMs/iou-$thisEpoch/iou-$thisEpoch.blockchains.vdi"

VBoxManage storageattach "iou-$thisEpoch"  --storagectl "SATA Controller" --port 6 --device 0 --type dvddrive --medium /usr/share/virtualbox/VBoxGuestAdditions.iso --hotpluggable on
#-------------------------------------------------------------------------------------

echo VBoxManage startvm "iou-$thisEpoch"
