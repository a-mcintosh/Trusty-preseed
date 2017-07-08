#!/bin/sh
#  ----------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- make an attendless Ubuntu installation CD
#  --   iounote-$EPOCH
#  ----------------------------------------------------------------
#  -- run this from the directory which contains the new add-on subdirectories.
#  -- typically, that is also the git repository.
#  ----------------------------------------------------------------
#  1. https://askubuntu.com/questions/122505/how-do-i-create-a-completely-unattended-install-of-ubuntu
#  ----------------------------------------------------------------

echo '#  ----------------------------------------------------------------'
echo pwd: `pwd`
echo ls ..: `ls ..`
echo '#  ----------------------------------------------------------------'

echo "\$Id$"$EPOCH > this.epoch
if [ ! -e isolinux/isolinux.bin ]
  then 
    cp ~/opt/iso/in/isolinux/isolinux.bin isolinux/;
    chmod u+w isolinux/isolinux.bin
fi

mkisofs -D -r -input-charset utf-8 \
  -V iounote-$EPOCH -cache-inodes -J -l \
  -b isolinux/isolinux.bin -c isolinux/boot.cat \
  -no-emul-boot \
  -boot-load-size 4 -boot-info-table \
  -m '*~' \
  -m lost+found \
  -m ~/opt/iso/in/origin.txt \
  -m ~/opt/iso/in/isolinux/boot.cat \
  -m ~/opt/iso/in/isolinux/isolinux.bin \
  -m ~/opt/iso/in/isolinux/txt.cfg \
  -m ~/opt/iso/in/preseed/iounote.seed \
  -m ~/opt/iso/in/bin \
  -o ~/opt/iso/out/ubuntu-14.04.5-iounote-$EPOCH-amd64.iso \
     . ~/opt/iso/in/
echo '#  ----------------------------------------------------------------'
ssh amcintosh@host mkdir -p "~"/projects/iounote/$EPOCH
scp ~/opt/iso/out/ubuntu-14.04.5-iounote-$EPOCH-amd64.iso amcintosh@host:'~'/projects/iounote/$EPOCH/.
scp ./bin/001-createVM-14.04.5.sh amcintosh@host:'~'/projects/iounote/$EPOCH/.
ssh amcintosh@host "cd ~/projects/iounote/$EPOCH; ./001-createVM-14.04.5.sh"
ssh amcintosh@host "VBoxManage startvm iounote-$EPOCH &"

