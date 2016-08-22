#!/bin/sh
# change_application_part.sh - Change application part in current_partition_part and env_var files

# Get the inactive application partition 
get_innactive_partition () {

  if [ "$CURRENT_APP_PART" = $(cat $CONFIG_DATA | sed -n '/main_partition=/p' | cut -d= -f2) ]
  then 
    echo $(cat $CONFIG_DATA | sed -n '/alt_partition=/p' | cut -d= -f2) 
  else
    echo $(cat $CONFIG_DATA | sed -n '/main_partition=/p' | cut -d= -f2)   
  fi
}

case $1 in 
  "change") CURRENT_APP_PART=$(get_innactive_partition)
            echo $CURRENT_APP_PART > $CURRENT_APPLICATION_PART_FILE
            ;;
  
  "temp") TEMP_APP_PART=$(get_innactive_partition)
          echo "TEMP_APP_PART=$TEMP_APP_PART" >> $ENVIRONNEMENT_SCRIPT 
          ;;
  esac
