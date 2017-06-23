#!/bin/bash
#  -- Aubrey McIntosh, Ph.D.  $Id$

pushd	iouscript-install-shellscripts
mv	createVM-14.04.3.sh 		001-createVM-14.04.3.sh
mv	make-iso-14.04.3-coins.sh	004-make-iso-14.04.3-coins.sh
mv	make-iso-14.04.3.sh		004-make-iso-14.04.3.sh
mv	make.minerd.env.sh		003-make.minerd.env.sh
mv	post-install-new-system.sh	002-post-install-new-system.sh
ls -l
popd

pushd	preseed				
mv	preseed.iou-script-1		preseed.iounote-1
popd

gedit iouscript-install-shellscripts/001-createVM-14.04.3.sh  iouscript-install-shellscripts/002-post-install-new-system.sh iouscript-install-shellscripts/003-make.minerd.env.sh iouscript-install-shellscripts/004-make-iso-14.04.3-coins.sh iouscript-install-shellscripts/004-make-iso-14.04.3.sh preseed/preseed-14.04.3 preseed/preseed-14.04.3-tuned-6.6 preseed/preseed.iounote-1 &


