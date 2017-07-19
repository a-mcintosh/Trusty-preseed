#!/bin/bash
#-------------------------------------------------------------------------------------
#  -- Aubrey McIntosh, Ph.D.  $Id$
#  -- copy some 'content' data to the new installation 
#  --
#-------------------------------------------------------------------------------------

cd ~passwd/username
scp -rp -i ~passwd/username/.ssh/id_rsa-one-shot-1500056099 aubrey@iounote:bin bin/
scp -rp -i ~passwd/username/.ssh/id_rsa-one-shot-1500056099 aubrey@iounote:bash-history bash-history/
scp -rp -i ~passwd/username/.ssh/id_rsa-one-shot-1500056099 aubrey@iounote:.iounote/ .iounote/
scp -rp -i ~passwd/username/.ssh/id_rsa-one-shot-1500056099 aubrey@iounote:.bytecoin/ .bytecoin/
scp -rp -i ~passwd/username/.ssh/id_rsa-one-shot-1500056099 aubrey@iounote:.config/autostart/iounote-qt.desktop /home/aubrey/.config/autostart/
scp -rp -i ~passwd/username/.ssh/id_rsa-one-shot-1500056099 aubrey@iounote:/var/opt /var/opt

