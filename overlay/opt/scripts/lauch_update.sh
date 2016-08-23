#!/bin/sh
# lauch_update.sh - A shell script to lauch update

# Select rootfs partition to update (main or alt) due to u-boot variable
find_fs () {
 
  current_part=$($PRINTENV_CMD $CURRENT_ROOTFS_PART | cut -d= -f2)
  if [ "$current_part" -eq 0 ]
  then
    UPDATED_PARTITION="rootfs,alt"
  else
    UPDATED_PARTITION="rootfs,main"
  fi
  echo "$UPDATED_PARTITION"
}

# Select application partition to update (main or alt) due to environnement variables
find_app () {
 
  if [ "$CURRENT_APP_PART" = $(cat $CONFIG_DATA | sed -n '/main_partition=/p' | cut -d= -f2) ]
  then 
    UPDATED_PARTITION="application,alt"
  else
    UPDATED_PARTITION="application,main"
  fi
  echo "$UPDATED_PARTITION"
}

# Get log messages
catch_returned_msg () {
  
  error_value=$( echo "$1" | grep ERROR)
  if [ "$error_value" ]
  then 
    echo "$(date "+%F %H:%M:%S") [$2] $error_value" >> $FILE_SWUPDATE_LOG
    echo "failed"
  else 
    success_value=$( echo "$1" | grep "updated successfully")
    echo "$(date "+%F %H:%M:%S") [$2] $success_value" >> $FILE_SWUPDATE_LOG
    echo "success"
  fi
}

# Lauch the correct update (app or system) and verify if immediate reboot is needed
lauch_update () {

  mount $BOOT_PARTITION /mnt
  rootfs_state="false"
  app_state="false" 

  if [ "$UPDATE_STATE" = "UPDATE_SYSTEM" -a "$APP_STATE" = "WAIT" ]; then 
    UPDATED_PARTITION=$(find_fs)
    rootfs_state=$(catch_returned_msg "$(swupdate -k ${FILE_PUBLIC_KEY} -e ${UPDATED_PARTITION} -vi "${DIR_UPDATE}/$ROOTFS_UPDATE_NAME")" "ROOTFS")
    if [ "$rootfs_state" = "success" ]; then 
      UPDATED_PARTITION=$(find_app)
      app_state=$(catch_returned_msg "$(swupdate -k ${FILE_PUBLIC_KEY} -e ${UPDATED_PARTITION} -vi "${DIR_UPDATE}/$APPLI_UPDATE_NAME")" "APP")
    else 
      catch_returned_msg "ERROR : Rootfs update failed, App update cancelled" "APP"
    fi

    if [ "$rootfs_state" = "success" -a "$app_state" = "success" ]; then 
      UPDATE_STATE="SYSTEM_UPDATED"
      source $SCRIPT_CHANGE_APP_PART "temp"
    else 
      # if error wait next update
      UPDATE_STATE="WAIT" 
    fi
    source $SCRIPT_SAVE_ENVIRONNEMENT
    
  elif [ "$UPDATE_STATE" = "UPDATE_APP" ]; then  
    UPDATED_PARTITION=$(find_app)
    app_state=$(catch_returned_msg "$(swupdate -k ${FILE_PUBLIC_KEY} -e ${UPDATED_PARTITION} -vi "${DIR_UPDATE}/$APPLI_UPDATE_NAME")" "APP")
    if [ "$app_state" = "success" ]
    then 
      UPDATE_STATE="APP_UPDATED"
      source $SCRIPT_CHANGE_APP_PART "temp"
    else 
      # if error wait next update
      UPDATE_STATE="WAIT" 
    fi
    source $SCRIPT_SAVE_ENVIRONNEMENT
  fi

  umount $BOOT_PARTITION 

  if [ "$(echo $APPLI_UPDATE_NAME | cut -d_ -f4)" = "REBOOT" ]
  then 
    REBOOT="1"
  else 
    REBOOT="0"
  fi
}

lauch_update 

