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
  echo "Update root file system on ${UPDATED_PARTITION}"
}

find_app () {
  current_part=$(fw_printenv "appli" | cut -d= -f2)
  if [ "$current_part" -eq 0 ]
  then
    UPDATED_PARTITION="application,alt"
  else
    UPDATED_PARTITION="application,main"
  fi
  echo "Update application on ${UPDATED_PARTITION}"
}

lauch_update () {
  UPDATED_PARTITION=$(find_fs)
  swupdate -k ${PUBLIC_KEY_PATH} -H raspb:revA -e ${UPDATED_PARTITION} -vi "${UPDATE_DIR}/$1"
  #verif if ok 
  UPDATED_PARTITION=$(find_app)
  swupdate -k ${PUBLIC_KEY_PATH} -H raspb:revA -e ${UPDATED_PARTITION} -vi "${UPDATE_DIR}/$1"
}

lauch_update $1

