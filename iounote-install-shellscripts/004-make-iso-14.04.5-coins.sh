#!/bin/sh
#  ----------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- make an attendless Ubuntu installation CD
#  --   coins-$EPOCH
#  ----------------------------------------------------------------
#  -- run this from the directory which contains the new add-on subdirectories.
#  ----------------------------------------------------------------
#  1. https://askubuntu.com/questions/122505/how-do-i-create-a-completely-unattended-install-of-ubuntu
#  ----------------------------------------------------------------

echo '#  ----------------------------------------------------------------'
touch epoch--$EPOCH
echo pwd: `pwd`
echo ls ..: `ls ..`
echo '#  ----------------------------------------------------------------'

mkisofs -D -r \
  -V coins-$EPOCH -cache-inodes -J -l \
  -b isolinux/isolinux.bin -c isolinux/boot.cat \
  -no-emul-boot \
  -boot-load-size 4 -boot-info-table \
  -m '*~' \
  -m lost+found \
  -m ~/opt/iso/in/origin.txt \
  -m ~/opt/iso/in/isolinux/boot.cat \
  -m ~/opt/iso/in/isolinux/txt.cfg \
  -m ~/opt/iso/in/preseed/preseed-14.04.5 \
  -m ~/opt/iso/in/shop-jigs \
  -o ~/opt/iso/out/ubuntu-14.04.5-coins-$EPOCH-amd64.iso \
     . ~/opt/iso/in/
echo '#  ----------------------------------------------------------------'
ssh amcintosh@host mkdir -p "~"/projects/coins/$EPOCH
scp ~/opt/iso/out/ubuntu-14.04.5-coins-$EPOCH-amd64.iso amcintosh@host:'~'/projects/coins/$EPOCH/.
scp ./iounote-install-shellscripts/001-createVM-14.04.5.sh amcintosh@host:'~'/projects/coins/$EPOCH/.
