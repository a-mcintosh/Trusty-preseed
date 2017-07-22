#!/bin/bash
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- copy some ~aubrey 'content' data to the new installation 
#  --
#-------------------------------------------------------------------------------------
touch in-007-copy-IOUnote.sh
cd ~passwd/username
groupadd iounote
usermod -a -G iounote passwd/username

scp -rp -v aubrey@iounote:bin/ ~passwd/username/
scp -rp -v aubrey@iounote:bash-history bash-history/
scp -rp -v aubrey@iounote:.bytecoin/ .bytecoin/
scp -rp -v aubrey@iounote:/var/opt /var/opt
scp -rp -v aubrey@iounote:.iounote/ .iounote/
rm -r .iounote/{blocks,chainstate,database}

