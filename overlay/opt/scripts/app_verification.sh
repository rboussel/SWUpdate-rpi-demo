#!/bin/sh
# app_verification.sh - A shell script to check app state after update

# Variables 
APP_VERIFICATION_VALUE="ok" # Response of application validatation test (test is not implemented yet)

# Write new version in config file
write_version () {
# Args 
# $1 - "appli" or "rootfs"

  if [ "$1" = "appli" ]; then  
    new_version=$(echo $APPLI_UPDATE_NAME | cut -d_ -f3)
    version=$(cat $FILE_CURRENT_VERSIONS | sed -n '/Application/p' | cut -d= -f2)
    sed -i "s/$version/$new_version/" $FILE_CURRENT_VERSIONS
  elif [ "$1" = "rootfs" ]
  then 
    new_version=$(echo $ROOTFS_UPDATE_NAME | cut -d_ -f3)
    version=$(cat $FILE_CURRENT_VERSIONS | sed -n '/Rootfs/p' | cut -d= -f2)
    sed -i "s/$version/$new_version/" $FILE_CURRENT_VERSIONS
  fi
}

# Check application validation 
wait_application_validation () {
  
  if [ "$APP_VERIFICATION_VALUE" = "ok" ]; then 
    APP_STATE="WAIT"
    write_version "appli"
    if [ "$UPDATE_STATE" = "SYSTEM_UPDATED" ]; then  
       write_version "rootfs"
    fi
    source $SCRIPT_CHANGE_APP_PART "change"
    source $SCRIPT_WAIT_UPDATE
  else  # If application does not work, use previous version ( the other partition)
    APP_STATE="PREVIOUS_VERSION"
    if [ "$UPDATE_STATE" = "SYSTEM_UPDATED" ]; then 
      fw_setenv "part" 'setexpr part ${part} ^ 1' # Change rootfs too
    fi
    source $SCRIPT_INVALIDATE_UPDATE $APPLI_UPDATE_NAME
    UPDATE_STATE="WAIT"
    reboot
  fi
}

mount $BOOT_PARTITION /mnt # Mount u-boot partition

wait_application_validation

umount $BOOT_PARTITION
source $SCRIPT_SAVE_ENVIRONNEMENT
