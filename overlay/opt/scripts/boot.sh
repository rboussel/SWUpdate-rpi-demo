#!/bin/sh
# boot.sh - Script to lauch system when verification finished
SCRIPTS_PATH="/opt/scripts"

R="2"


# Reset some variables and wait for a new update 
wait_update () {
  fw_setenv test_validity "true"
  fw_setenv retry_count "$R"
  UPDATE_STATE="WAIT"
  APP_COUNTER="3"
  mount $CURRENT_APP_PART "/APP"
  sed -i '/APPLI_UPDATE_NAME/d' "$SCRIPTS_PATH/env_var"   
  sed -i '/ROOTFS_UPDATE_NAME/d' "$SCRIPTS_PATH/env_var"  
}

mount /dev/mmcblk0p1 /mnt
wait_update
umount /dev/mmcblk0p1

source "${SCRIPTS_PATH}/save_env"
