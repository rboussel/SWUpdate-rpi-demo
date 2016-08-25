SWUpdate Raspberry-pi demo 
==========================

Project 
-------
This project is a demo of a complete update schema in the Raspberry Pi. 
[SWUpdate] (http://sbabic.github.io/swupdate) is used to update images and u-boot as a bootloader. 
Several shell scripts are used to verify the update. 

Buildroot submodule is used to build the Rpi images and [Swu-generator] (https://github.com/rboussel/swu-generator) is used to create the .swu archive. 

- mountpoint/data folder contains configuration and log files. This is the Data partition.
- overlay folder contains all scripts necessary to update the system.
The init update verification script is in usr/sbin folder and the other in opt folder. 
- rpi-scripts folder contains u-boot script
- swupdate folder contains an exemple of sw-description and a script to create the .swu archive. 
They are not used in the demo. 

Principle
---------
In this demo, the target has six partitions

- mmcblk0p1 - U-boot
- mmcblk0p2 - Kernel + Rootfs-1
- mmcblk0p3 - Kernel + Rootfs-2 
- mmcblk0p5 - Application-1
- mmcblk0p6 - Application-2
- mmcblk0p7 - Data

mmcblk0p3 and mmcblk0p6 are rootfs and application copies.
With the dual-copy strategy, SWUpdate update the inactive partition 
while the active partition is running. When the system reboots,
u-boot boots the updated partition. 
If the new partitions are corrupted, u-boot or init script changed current rootfs and 
application partitions.

Update schema
-------------
To verify update and partition state, three variables are used :

- test_validy : Enable to validate rootfs update. This is an u-boot variable
- UPDATE_STATE : Give the update state and enable to get back the update in case of power off
- APP_STATE : Enable to know if the previous application update fails or not

In this demo, the system get update archives from FTP server with the script get_archive_name.sh. 
This script verifies if there is a new archive and launch update. After the system reboot, 
the script verify_update checks if there was an update and launches application and rootfs verification. 



