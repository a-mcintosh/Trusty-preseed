#!/bin/sh
#  -- https://help.ubuntu.com/community/InstallCDCustomization/AccessDebconfFromYourScript
# A debconf-compatible script example.
. /usr/share/debconf/confmodule

# Create a template file, for our interaction with the user.
cat > /tmp/MyInstall.template <<'!EOF!'
Template: debian-installer/my-install/title
Type: text
# Main menu item
# :sl1:
Description: Installation of the core Operating System components has now completed.
 Additional software, and supporting applications, will now be installed.

Template: my-install/progress/title
Type: text
# :sl1:
Description: Installing Additional Components...

Template: my-install/asktheuser
Type: string
Description: Just type anything here.
!EOF!

debconf-loadtemplate snare-install /tmp/MyInstall.template

STEPS=10
db_progress START 0 $STEPS my-install/progress/title

# Do something or other
db_progress STEP 1

db_progress INFO snare-install/progress/title
# Do something or other
db_progress STEP 1

db_input critical my-install/asktheuser || true
db_go

db_get my-install/asktheuser
USERRESPONSE=$RET

echo $USERRESPONSE > /var/log/TheUsersResponse
bash -c "cat /var/log/TheUsersResponse > /var/log/SomethingElse"

