#!/bin/sh

SCRIPT_PATH="uboot_env.hush"
DESTINATION_PATH="uboot_env.img"

create_swu_image(){

  mkimage -T script -C none -n 'Script init' -d ${SCRIPT_PATH} ${DESTINATION_PATH}
}

create_swu_image
