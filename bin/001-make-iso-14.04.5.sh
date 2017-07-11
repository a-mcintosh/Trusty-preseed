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
    cp ~/opt/iso/in/isolinux/isolinux.bin isolinux/;
    chmod u+w isolinux/isolinux.bin
fi

ssh-keygen -N "This becomes an authorized key." -f bin/id_rsa-$EPOCH
#  -- remember: sudo sed -i.bak '/aubrey@iounote/d' ~git/.ssh/authorized_keys
ssh-keygen -f bin/id_rsa  #One shot git key to clone WWW.  secret passphrase
#tbd sed -i /ssh/s/^/command=git\ / bin/id_rsa.pub
ssh-copy-id -i bin/id_rsa git@iounote.quarantine

mkisofs -D -r -input-charset utf-8 \
  -V IOUnote-$EPOCH -cache-inodes -J -l \
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
  -m id_rsa-$EPOCH \
  -m /home/aubrey/opt/iso/in/README.md \
  -m /home/aubrey/opt/iso/in/this.epoch \
  -m /home/aubrey/opt/iso/in/.gitattributes \
  -m /home/aubrey/opt/iso/in/.gitignore \
  -m /home/aubrey/opt/iso/in/.git \
  -o ~/opt/iso/out/ubuntu-14.04.5-iounote-$EPOCH-amd64.iso \
     . ~/opt/iso/in/
echo '#  ----------------------------------------------------------------'
ssh amcintosh@host mkdir -p "~"/projects/iounote/$EPOCH
scp ~/opt/iso/out/ubuntu-14.04.5-iounote-$EPOCH-amd64.iso amcintosh@host:'~'/projects/iounote/$EPOCH/.
scp ./bin/002-createVM-14.04.5.sh amcintosh@host:'~'/projects/iounote/$EPOCH/.
ssh amcintosh@host "cd ~/projects/iounote/$EPOCH; ./002-createVM-14.04.5.sh"
ssh amcintosh@host "VBoxManage startvm iounote-$EPOCH &"

