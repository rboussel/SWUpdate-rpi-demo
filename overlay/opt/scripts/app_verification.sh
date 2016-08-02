#!/bin/sh
# app_verification.sh - A shell script to check app state after update
SCRIPTS_PATH="/opt/scripts"

R="2"
val="ok"

# Write new version in config file
write_version () {

  if [ $1 = "appli" ]
  then 
    new_version=$(echo $APPLI_UPDATE_NAME | cut -d_ -f3)
    version=$(cat $CURRENT_VERSIONS_FILE | sed -n '/Application/p' | cut -d= -f2)
    sed -i "s/$version/$new_version/"  $CURRENT_VERSIONS_FILE
  elif [ $1 = "rootfs" ]
  then 
    new_version=$(echo $ROOTFS_UPDATE_NAME | cut -d_ -f3)
    version=$(cat $CURRENT_VERSIONS_FILE | sed -n '/Rootfs/p' | cut -d= -f2)
    sed -i "s/$version/$new_version/"  $CURRENT_VERSIONS_FILE
  fi
}

# Check application validation 
wait_application_validation () {
  #monter la deuxième partition
  if [ $val == "ok" ]
  then 
    APP_STATE="WAIT"
    write_version "appli"
    if [ $UPDATE_STATE == "SYSTEM_UPDATED" ]
    then 
       write_version "rootfs"
    fi
    source "$SCRIPTS_PATH/change_application_part.sh "change""
    wait_update
  else  
    APP_STATE="PREVIOUS_VERSION"
    if [ $UPDATE_STATE == "SYSTEM_UPDATED" ]
    then
      fw_setenv "part" 'setexpr part ${part} ^ 1'
    fi
    source "$SCRIPTS_PATH/invalidate_update.sh" $APPLI_UPDATE_NAME
    UPDATE_STATE="WAIT"
    reboot
  fi
}

mount /dev/mmcblk0p1 /mnt

wait_application_validation

umount /dev/mmcblk0p1
source "${SCRIPTS_PATH}/save_env"
