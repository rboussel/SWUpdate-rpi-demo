#!/bin/sh

UPDATE_DIR="/DATA/update"
PUBLIC_KEY_PATH="${UPDATE_DIR}/public.pem"


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
  current_part=$(fw_printenv "appli" | cut -d= -f2)
  if [ "$current_part" -eq 0 ]
  then
    UPDATED_PARTITION="application,alt"
  else
    UPDATED_PARTITION="application,main"
  fi
  echo "{UPDATED_PARTITION}"
}

lauch_update () {
  mount /dev/mmcblk0p1 /mnt
  UPDATED_PARTITION=$(find_fs)
  swupdate -k ${PUBLIC_KEY_PATH} -e ${UPDATED_PARTITION} -vi "${UPDATE_DIR}/$1"
  #verif if ok 
  UPDATED_PARTITION=$(find_app)
  swupdate -k ${PUBLIC_KEY_PATH} -e ${UPDATED_PARTITION} -vi "${UPDATE_DIR}/$1"
  umount /dev/mmcblk0p1
}

lauch_update $1

