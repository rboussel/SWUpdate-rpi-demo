#!/bin/sh
# lauch_update.sh - A shell script to lauch update 

# Select rootfs partition to update (main or alt) due to u-boot variable
find_fs () {
  current_part=$(fw_printenv "part" | cut -d= -f2)
  if [ "$current_part" -eq 0 ]
  then
    UPDATED_PARTITION="rootfs,alt"
  else
    UPDATED_PARTITION="rootfs,main"
  fi
  echo "${UPDATED_PARTITION}"
}

# Select application partition to update (main or alt) due to environnement variable
find_app () {
  if [ $CURRENT_APP_PART == $(cat $CONFIG_DATA | sed -n '/main_partition=/p' | cut -d= -f2) ]
  then 
    UPDATED_PARTITION="application,alt"
  else
    UPDATED_PARTITION="application,main"
  fi
  echo "${UPDATED_PARTITION}"
}


# Lauch the correct update (app or system) and verify if immediate reboot is needed
lauch_update () {
  mount $(cat $CONFIG_DATA | sed -n '/BOOT_partition=/p' | cut -d= -f2) /mnt

  if [ "$UPDATE_STATE == "UPDATE_SYSTEM"" -a "$APPLI_STATE = "WAIT"" ]
  then 
    UPDATED_PARTITION=$(find_fs)
    swupdate -k ${PUBLIC_KEY_PATH} -e ${UPDATED_PARTITION} -vi "${UPDATE_DIR}/$ROOTFS_UPDATE_NAME"
    UPDATE_STATE="SYSTEM_UPDATED"
    source "$SCRIPT_PATH/save_env"
    #verif if ok 
  elif [ $UPDATED_PARTITION = "UPDATE_APP" ]
  then 
    UPDATE_STATE="APP_UPDATED"
    source "$SCRIPT_PATH/save_env"
  fi

  UPDATED_PARTITION=$(find_app)
  swupdate -k ${PUBLIC_KEY_PATH} -e ${UPDATED_PARTITION} -vi "${UPDATE_DIR}/$APPLI_UPDATE_NAME"
  
# A completer
  source "$SCRIPTS_PATH/change_application_part.sh"
  umount $(cat $CONFIG_DATA | sed -n '/BOOT_partition=/p' | cut -d= -f2) 

  if [ "$(echo $APPLICATION_UPDATE_NAME | cut -d_ -f4)" = "REBOOT" ]
  then 
    REBOOT="1"
  else 
    REBOOT="0"
  fi
}

lauch_update 

