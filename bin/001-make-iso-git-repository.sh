#!/bin/bash
#  ----------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- git repository transfer CD
#  ----------------------------------------------------------------
#  -- run this from the ~/opt/iso/Trusty-preseed directory
#  ----------------------------------------------------------------

echo '#  ----------------------------------------------------------------'

echo "\$Id$"$EPOCH > git.epoch

mkisofs -D -r -input-charset utf-8 \
  -V IOUnote-git-$EPOCH -cache-inodes -J -l \
  -m lost+found \
  -m .ssh \
  -m .bash_history \
  -m .cache \
  -o ../tmp/git-repository-iounote-$EPOCH.iso \
     ~git
echo '#  ----------------------------------------------------------------'
ssh amcintosh@host mkdir -p "~"/projects/iounote/$EPOCH
scp ../tmp/git-repository-iounote-$EPOCH.iso amcintosh@host:'~'/projects/iounote/$EPOCH/.

