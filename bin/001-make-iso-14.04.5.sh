#!/bin/bash
#  ----------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- make an attendless Ubuntu installation CD for 14.04.5 LTS (Trusty Tahr)
#  ----------------------------------------------------------------
#  -- run this from ~/opt/iso  
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
    cp ../cdrom/isolinux/isolinux.bin isolinux/;
    chmod u+w isolinux/isolinux.bin
fi

rm bin/.ssh/id_rsa{,-$EPOCH}{,.pub}
ssh-keygen -N "This becomes an authorized key." -f bin/.ssh/id_rsa-$EPOCH
#  -- remember: sudo sed -i.bak '/aubrey@iounote/d' ~git/.ssh/authorized_keys
ssh-keygen -N "" -f bin/.ssh/id_rsa  #One shot git key to clone WWW.  No passphrase
ssh-copy-id -i bin/.ssh/id_rsa git@iounote.quarantine

mkisofs -D -r -input-charset utf-8 \
  -V IOUnote-$EPOCH -cache-inodes -J -l \
  -b isolinux/isolinux.bin -c isolinux/boot.cat \
  -no-emul-boot \
  -boot-load-size 4 -boot-info-table \
  -m '*~' \
  -m lost+found \
  -m ../cdrom/origin.txt \
  -m ../cdrom/isolinux/boot.cat \
  -m ../cdrom/isolinux/isolinux.bin \
  -m ../cdrom/isolinux/txt.cfg \
  -m ../cdrom/preseed/iounote.seed \
  -m ../cdrom/preseed/IOUnote.seed \
  -m ../cdrom/bin \
  -m id_rsa-$EPOCH \
  -m ../cdrom/README.md \
  -m ../cdrom/this.epoch \
  -m ../cdrom/.gitattributes \
  -m ../cdrom/.gitignore \
  -m ../cdrom/.git \
  -o ../tmp/ubuntu-14.04.5-iounote-$EPOCH-amd64.iso \
     . ../cdrom/
echo '#  ----------------------------------------------------------------'
ssh amcintosh@host mkdir -p "~"/projects/iounote/$EPOCH
scp ../tmp/ubuntu-14.04.5-iounote-$EPOCH-amd64.iso amcintosh@host:'~'/projects/iounote/$EPOCH/.
scp ./bin/001-createVM-14.04.5.sh amcintosh@host:'~'/projects/iounote/$EPOCH/.
ssh amcintosh@host "cd ~/projects/iounote/$EPOCH; ./001-createVM-14.04.5.sh"
ssh amcintosh@host "VBoxManage startvm iounote-$EPOCH &"

