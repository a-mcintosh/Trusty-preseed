#!/bin/bash
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
