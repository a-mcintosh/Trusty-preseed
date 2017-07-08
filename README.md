# Unattended install of Ubuntu 14.04 LTS (Trusty Tahr)

$Id$

Tested and working under 
*  VirtualBox 5.1.22 r115126
*  Host: Ubuntu 14.04.5 LTS (Trusty)
*  Guest: Ubuntu 14.04.5 LTS (Trusty)

Shell scripts and preseed files to 
*  create an Ubuntu .iso image,
*  create a Virtualbox machine,
*  install Trusty Tahr mostly unattended (automatic).

This git
* creates a custom LVM partitioning scheme
* invokes a shell-script after the installation for additional configuration.

To use:
* It is a cyclic process, so you can start anywhere, but the entry details change each place.
* This is code for one of my projects.  You will have to wade through lots of path names and the like and localize them to your project.  
* You are welcome to make a branch named "vanilla" that isn't infused with my projet.
* Be sure you can ssh into "host"  This installation can run on "host" or anywhere else.  The resulting VirtualBox will be hosted on "host"
* export EPOCH=`date '+%s'`
* create ~/project/$EPOCH
* cp -p 001-createVM-14.04.5.sh ~/project/$EPOCH/
* cp <any.trusty.14.04.5.iso> ~/project/$EPOCH/ubuntu-14.04.5-iounote-$thisEpoch-amd64.iso
* ./001-createVM-14.04.5.sh

To do:  Make it more generic.  This is best done by someone who is adapting it for themself.

## This .iso image auto-starts and formats the disks.
