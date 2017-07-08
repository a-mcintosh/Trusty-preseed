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

To do:  Make it more generic.  This is best done by someone who is adapting it for themself.

## This .iso image auto-starts and formats the disks.
