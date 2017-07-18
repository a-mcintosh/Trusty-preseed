#!/bin/bash
#  ----------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- opt repository transfer CD
#  ----------------------------------------------------------------
#  -- run this from ~/opt/iso/Trusty-preseed
#  -- I haven't decided whether things in ~/opt are all in git repositories elsewhere, or not.
#  ----------------------------------------------------------------

echo '#  ----------------------------------------------------------------'
echo "\$Id$"$EPOCH > opt.epoch

mkisofs -D -r -input-charset utf-8 \
  -V IOUnote-opt-$EPOCH -cache-inodes -J -l \
  -m lost+found \
  -m .ssh \
  -m .bash_history \
  -m .cache \
  -m .Trash-1000 \
  -m cdrom \
  -m `pwd` \
  -m tmp \
  -o ../tmp/opt-repository-iounote-$EPOCH.iso \
  ~/opt
echo '#  ----------------------------------------------------------------'
ssh amcintosh@host mkdir -p "~"/projects/iounote/$EPOCH
scp ../tmp/opt-repository-iounote-$EPOCH.iso amcintosh@host:'~'/projects/iounote/$EPOCH/.

