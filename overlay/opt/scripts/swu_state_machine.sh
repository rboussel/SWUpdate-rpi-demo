#!/bin/sh
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

retry_update () {
  retry_count_val=$(decrement_variable "retry_count")
  if [ "$retry_count_val" -gt 0 ]
  then
    ./lauch_update ${UPDATE_NAME}
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

