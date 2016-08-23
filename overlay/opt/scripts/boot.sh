#!/bin/sh
# boot.sh - Script to lauch system when updated verification finished

# Variables
R="2" # Number of try for rootfs boot

# Reset some variables and wait for a new update 
wait_update () {

  $SETENV_CMD $VALIDATION_UPDATE "true" # Validate update
  $SETENV_CMD $RETRY_ROOTFS_UPDATE_COUNTER "$R" # Reset rootfs counter
  UPDATE_STATE="WAIT"  
  umount "/APP"
  mount $CURRENT_APP_PART "/APP" 
  sed -i '/TEMP_APP_PART/d' $SCRIPT_ENVIRONNEMENT   # Remove temporary environnement variables
  sed -i '/APPLI_UPDATE_NAME/d' $SCRIPT_ENVIRONNEMENT   # Remove temporary environnement variables
  sed -i '/ROOTFS_UPDATE_NAME/d' $SCRIPT_ENVIRONNEMENT  
}

mount $BOOT_PARTITION /mnt # Mount u-boot partition
wait_update
umount /mnt

source $SCRIPT_SAVE_ENVIRONNEMENT
