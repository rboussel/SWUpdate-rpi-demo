#!/bin/sh

change_partition () {
if [ $CURRENT_APP_PART == $(cat $CONFIG_DATA | sed -n '/main_partition=/p' | cut -d= -f2) ]
then 
  CURRENT_APP_PART=$(cat $CONFIG_DATA | sed -n '/alt_partition=/p' | cut -d= -f2) 
else
  CURRENT_APP_PART=$(cat $CONFIG_DATA | sed -n '/main_partition=/p' | cut -d= -f2)   
fi
}

change_partition
