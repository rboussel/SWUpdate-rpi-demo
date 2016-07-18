#!/bin/sh
# change_application_part.sh - Change application part in current_partition_part and env_var files
change_partition () {
if [ $CURRENT_APP_PART == $(cat $CONFIG_DATA | sed -n '/main_partition=/p' | cut -d= -f2) ]
then 
  CURRENT_APP_PART=$(cat $CONFIG_DATA | sed -n '/alt_partition=/p' | cut -d= -f2) 
else
  CURRENT_APP_PART=$(cat $CONFIG_DATA | sed -n '/main_partition=/p' | cut -d= -f2)   
fi

echo $CURRENT_APP_PART > "/DATA/current_application_part"
}
change_partition
