#!/bin/sh
CURRENT_APPLICATION_PART_PATH="/DATA/current_application_part"

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

find_app () {
  current_partition_part=$(cat $CURRENT_APPLICATION_PART_PATH)
  if [ $current_partition_part == "/dev/mmcblk0p5" ]
  then 
    UPDATED_PARTITION="application,alt"
  else
    UPDATED_PARTITION="application,main"
  echo "${UPDATED_PARTITION}"
}

lauch_update () {
  mount /dev/mmcblk0p1 /mnt
  mount /dev/mmcblk0p7 /DATA
  UPDATED_PARTITION=$(find_fs)
  swupdate -k ${PUBLIC_KEY_PATH} -e ${UPDATED_PARTITION} -vi "${UPDATE_DIR}/$ROOTFS_UPDATE_NAME"
  #verif if ok 
  UPDATED_PARTITION=$(find_app)
  swupdate -k ${PUBLIC_KEY_PATH} -e ${UPDATED_PARTITION} -vi "${UPDATE_DIR}/$APPLICATION_UPDATE_NAME"
  umount /dev/mmcblk0p1
  umount /dev/mmcblk0p7
}

lauch_update 

