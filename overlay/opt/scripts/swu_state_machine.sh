#!/bin/sh
UPDATE_DIR="/DATA/update"
PUBLIC_KEY_PATH="${UPDATE_DIR}/public.pem"
UPDATE_NAME="swupdate_1.0.swu"
R="2"

wait_update () {
  fw_setenv test_validity "true"
  fw_setenv retry_count "$R"
}

decrement_variable () {
  new_value=$(fw_printenv $1 | cut -d= -f2)
  let new_value--
  fw_setenv $1 $new_value 
  echo $new_value
}

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
  swupdate -k ${PUBLIC_KEY_PATH} -H raspb:revA -e ${UPDATED_PARTITION} -vi "${UPDATE_DIR}/${UPDATE_NAME}"
  #verif if ok 
  UPDATED_PARTITION=$(find_app)
  swupdate -k ${PUBLIC_KEY_PATH} -H raspb:revA -e ${UPDATED_PARTITION} -vi "${UPDATE_DIR}/${UPDATE_NAME}"
}

retry_update () {
  retry_count_val=$(decrement_variable "retry_count")
  if [ "$retry_count_val" -gt 0 ]
  then
    lauch_update
  else 
    ./invalidate_update.sh ${UPDATE_NAME}
    wait_udpate
  fi
}

check_value () {
  val_count=$(fw_printenv $1 | cut -d= -f2)
  if [ "$val_count" -gt "0" ]; then wait_update ; else retry_update ; fi
}

# Specific commands to Raspberry Pi for u-boot environment
mount /dev/mmcblk0p1 /mnt
echo "/mnt/uboot.env 0x0000 0x4000 0x4000" > /etc/fw_env.config

fw_printenv test_validity | grep "true" && wait_update || check_value "test_count"

