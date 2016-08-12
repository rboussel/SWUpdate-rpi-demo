#!/bin/sh
# boot.sh - Script to lauch system when updated verification finished

# Variables
R="2" # Number of try for rootfs boot


# Reset some variables and wait for a new update 
wait_update () {

  fw_setenv test_validity "true" # Validate update
  fw_setenv retry_count "$R" # Reset rootfs counter
  UPDATE_STATE="WAIT"  

  mount $CURRENT_APP_PART "/APP" 
  sed -i '/APPLI_UPDATE_NAME/d' "$SCRIPTS_PATH/env_var"   # Remove temporary environnement variables
  sed -i '/ROOTFS_UPDATE_NAME/d' "$SCRIPTS_PATH/env_var"  
}

mount /dev/mmcblk0p1 /mnt # Mount u-boot partition
wait_update
umount /dev/mmcblk0p1

source "${SCRIPTS_PATH}/save_env"
