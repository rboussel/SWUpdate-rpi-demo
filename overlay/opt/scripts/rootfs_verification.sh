#!/bin/sh
# rootfs_verification.sh - A shell script to check rootfs state after update
SCRIPTS_PATH="/opt/scripts"

R="2"
val="ok"


decrement_variable () {
  new_value=$(fw_printenv $1 | cut -d= -f2)
  let new_value--
  fw_setenv $1 $new_value 
  echo $new_value
}

# Retry rootfs update, if failed, invalidate rootfs and app version 
retry_update () {
  retry_count_val=$(decrement_variable "retry_count")
  if [ "$retry_count_val" -gt 0 ]
  then
    UPDATE_STATE="UPDATE_SYSTEM"
    source "$SCRIPTS_PATH/save_env"
    source "$SCRIPTS_PATH/lauch_update.sh" 
  else
    "$SCRIPTS_PATH/invalidate_update.sh" $ROOTFS_UPDATE_NAME
    "$SCRIPTS_PATH/invalidate_update.sh" $APPLI_UPDATE_NAME
    source "$SCRIPTS_PATH/boot.sh"
  fi
}

# Check if rootfs boot correctly
check_value () {
  val_count=$(fw_printenv $1 | cut -d= -f2)
  if [ "$val_count" -gt "0" ]; then source "$SCRIPTS_PATH/app_verification.sh"; else retry_update ; fi
}

mount /dev/mmcblk0p1 /mnt

check_value "test_count"

umount /dev/mmcblk0p1 
