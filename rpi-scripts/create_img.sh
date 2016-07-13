#!/bin/sh
#Post build genimage script 

SCRIPT_PATH="${BR2_EXTERNAL}/rpi-scripts/uboot_env.hush"
DESTINATION_PATH="${BINARIES_DIR}/uboot_env.img"

create_swu_image(){

  mkimage -T script -C none -n 'Script init' -d ${SCRIPT_PATH} ${DESTINATION_PATH}
}

create_swu_image
