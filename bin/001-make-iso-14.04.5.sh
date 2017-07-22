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
echo $1
if [ -z ${1+x} ]; then 
  echo "Usage: 001-make-iso-14.04.5.sh <quoted ssh passphrase>"; 
  exit 1
else echo "The passphrase is: '$1'"; 
fi
git status
echo '#  ----------------------------------------------------------------'

echo "\$Id$"$EPOCH > this.epoch
if [ ! -e isolinux/isolinux.bin ]
  then 
    cp ../cdrom/isolinux/isolinux.bin isolinux/;
    chmod u+w isolinux/isolinux.bin
fi

rm bin/.ssh/id_rsa-one-shot-*
ssh-keyscan -t rsa iounote.quarantine.vima.austin.tx.us.  > bin/.ssh/known_hosts
ssh-keyscan -t rsa iounote                               >> bin/.ssh/known_hosts
ssh-keyscan -t rsa `dig iounote.quarantine.vima.austin.tx.us. AAAA | awk '/IN AAAA/ { print $5 }'` >> bin/.ssh/known_hosts
ssh-keyscan -t rsa    host.quarantine.vima.austin.tx.us. >> bin/.ssh/known_hosts
ssh-keyscan -t rsa    host                               >> bin/.ssh/known_hosts
ssh-keyscan -t rsa `dig host.quarantine.vima.austin.tx.us. AAAA | awk '/IN AAAA/ { print $5 }'` >> bin/.ssh/known_hosts

#  -- remember: sudo sed -i.bak '/aubrey@iounote/d' ~git/.ssh/authorized_keys

ssh-keygen -N "" -f bin/.ssh/id_rsa-one-shot-$EPOCH -C "id_rsa_one-shot-$EPOCH `whoami`@`hostname`"
ln bin/.ssh/id_rsa-one-shot-$EPOCH bin/.ssh/id_rsa
ln bin/.ssh/id_rsa-one-shot-$EPOCH.pub bin/.ssh/id_rsa.pub

ssh-copy-id -i bin/.ssh/id_rsa-one-shot-$EPOCH amcintosh@host.quarantine.vima.austin.tx.us.
ssh-copy-id -i bin/.ssh/id_rsa-one-shot-$EPOCH git@iounote.quarantine.vima.austin.tx.us.
ssh-copy-id -i bin/.ssh/id_rsa-one-shot-$EPOCH aubrey@iounote.quarantine.vima.austin.tx.us.

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
bin/001-make-iso-git-repository.sh
bin/001-make-iso-opt-repository.sh
echo '#  ----------------------------------------------------------------'
ssh amcintosh@host mkdir -p "~"/projects/iounote/$EPOCH
scp ../tmp/ubuntu-14.04.5-iounote-$EPOCH-amd64.iso amcintosh@host:'~'/projects/iounote/$EPOCH/.
scp ./bin/001-createVM-14.04.5.sh amcintosh@host:'~'/projects/iounote/$EPOCH/.
#  ----------------------------------------------------------------

ssh amcintosh@host "cd ~/projects/iounote/$EPOCH; ./001-createVM-14.04.5.sh"
ssh amcintosh@host "VBoxManage startvm iounote-$EPOCH &"





