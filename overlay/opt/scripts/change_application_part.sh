#!/bin/sh
# change_application_part.sh - Change application part in current_partition_part and env_var files

# Change current application partition after an update
change_partition () {

  if [ $CURRENT_APP_PART == $(cat $CONFIG_DATA | sed -n '/main_partition=/p' | cut -d= -f2) ]
  then 
    CURRENT_APP_PART=$(cat $CONFIG_DATA | sed -n '/alt_partition=/p' | cut -d= -f2) 
  else
    CURRENT_APP_PART=$(cat $CONFIG_DATA | sed -n '/main_partition=/p' | cut -d= -f2)   
  fi

  echo $CURRENT_APP_PART > "/DATA/update_files/current_application_part"
}

# Get the inactive application partition 
get_temp_part () {

  if [ $CURRENT_APP_PART == $(cat $CONFIG_DATA | sed -n '/main_partition=/p' | cut -d= -f2) ]
  then 
    echo $(cat $CONFIG_DATA | sed -n '/alt_partition=/p' | cut -d= -f2) 
  else
    echo $(cat $CONFIG_DATA | sed -n '/main_partition=/p' | cut -d= -f2)   
  fi
}

case $1 in 
  "change") change_partition ;;
  "temp") TEMP_APP_PART=$(get_temp_part)
          echo "TEMP_APP_PART=$TEMP_APP_PART" >> "$SCRIPTS_PATH/env_var" 
          ;;
  esac
