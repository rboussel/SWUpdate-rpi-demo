#!/bin/sh
# rootfs_verification.sh - A shell script to check rootfs state after update

decrement_variable () {

  new_value=$($PRINTENV_CMD $1 | cut -d= -f2)
  let new_value--
  $SENTENV_CMD $1 $new_value 
  echo $new_value
}

# Retry rootfs update, if failed, invalidate rootfs and app version 
retry_update () {
 
  retry_count_val=$(decrement_variable $RETRY_ROOTFS_UPDATE_COUNTER)
  if [ "$retry_count_val" -gt 0 ]
  then
    UPDATE_STATE="UPDATE_SYSTEM"
    source $SCRIPT_SAVE_ENVIRONNEMENT
    source $SCRIPT_LAUNCH_UPDATE 
  else
    source $SCRIPT_INVALIDATE_UPDATE $ROOTFS_UPDATE_NAME
    source $SCRIPT_INVALIDATE_UPDATE $APPLI_UPDATE_NAME
    source $SCRIPT_WAIT_UPDATE
  fi
}

# Check if rootfs boots correctly and launch application verification
check_value () {
 
  val_count=$($PRINTENV_CMD $1 | cut -d= -f2)
  if [ "$val_count" -gt "0" ]; then source $SCRIPT_APP_VERIFICATION; else retry_update ; fi
}

mount $BOOT_PARTITION /mnt

check_value $ROOTFS_COUNTER

umount /mnt
