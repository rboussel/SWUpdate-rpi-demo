#!/bin/sh
# get_archive_name.sh - A shell script to get new archive 

# Variables
ID="test"
PASS="test"
DOWNLOAD_DIR="/home/test"
SCRIPTS_PATH="/opt/scripts"
source "${SCRIPTS_PATH}/env_var" 

# Get last archive name in the FTP server. 
get_last_archive_name () {
 
  if [ $UPDATE_STATE = "WAIT" ] 
  then 
    #wget --no-remove-listing "ftp://$ID:$PASS@10.5.16.130/$DOWNLOAD_DIR"
    ls $UPDATE_DIR > ".listing"
    APPLI_UPDATE_NAME=$(sort ".listing" | grep .swu | grep APP | tail -1)
    echo "APPLI_UPDATE_NAME=$APPLI_UPDATE_NAME" >> "$SCRIPTS_PATH/env_var"
    UPDATE_STATE="GET_APP_ARCHIVE_NAME"
    source "${SCRIPTS_PATH}/save_env" 
  fi
  # Verify that new version is greater than the current version 
  new_version=$(echo $APPLI_UPDATE_NAME | cut -d_ -f3)
  current_version=$(get_version "appli")
  is_new=$(compare_versions $current_version $new_version)
  echo $is_new
}

# Parse archive's name to know which partition will be updated and download archives
which_part () {
 
  # Get application archive
  if [ $UPDATE_STATE = "GET_APP_ARCHIVE_NAME" ]
  then 
    #wget "ftp://$ID:$PASS@10.5.16.130/$DOWNLOAD_DIR/$APPLI_UPDATE_NAME"
    cd $UPDATE_DIR
    cpio -idv < $APPLI_UPDATE_NAME  
    UPDATE_STATE="GET_APP_ARCHIVE" 
    $APPLI_UPDATE_NAME=$(ls | sort | grep .swu | grep APP | tail -1)
    source "${SCRIPTS_PATH}/save_env"
    cd
  fi
    # Verify if new rootfs is needed
    rootfs_min_version=$(cat "$UPDATE_DIR/minimal_rootfs_version") 
    current_rootfs_version=$(get_version "rootfs")
    is_greater=$(compare_versions $current_rootfs_version $rootfs_min_version ) 
    
  if [ $is_greater = "yes" ]
  then
    if [ $UPDATE_STATE = "GET_APP_ARCHIVE" ]
    then 
      # Get rootfs name
      ROOTFS_UPDATE_NAME=$(sort ".listing" | grep .swu | grep ROOTFS | tail -1)
      echo "ROOTFS_UPDATE_NAME=$ROOTFS_UPDATE_NAME" >> "$SCRIPTS_PATH/env_var"
      UPDATE_STATE="GET_ROOTFS_NAME"
      source "${SCRIPTS_PATH}/save_env"
    fi
    
    if [ $UPDATE_STATE = "GET_ROOTFS_NAME" ]
    then 
      # Verify rootfs version validity
      if [ $(verify_validity $ROOTFS_UPDATE_NAME) = "yes" ]
      then
        # If the application version is not the previous, download the new rootfs, else we do not need it,
        # it is in the inactive rootfs partition
        if [ $APP_STATE = "WAIT" ]
        then 
          #wget "ftp://$ID:$PASS@10.5.16.130/$DOWNLOAD_DIR/$ROOTFS_UPDATE_NAME"
          UPDATE_STATE="UPDATE_SYSTEM"
          source "${SCRIPTS_PATH}/save_env"
        else 
          UPDATE_STATE="UPDATE_APP"
          source "${SCRIPTS_PATH}/save_env"
        fi
      else 
         # If rootfs invalid wait next update
         UPDATE_STATE="WAIT"
         source "${SCRIPTS_PATH}/save_env"
      fi
    fi
  else
    UPDATE_STATE="UPDATE_APP"
    source "${SCRIPTS_PATH}/save_env"
  fi

  if [ $UPDATE_STATE = "UPDATE_APP" -o $UPDATE_STATE = "UPDATE_SYSTEM" ]
  then 
    source "${SCRIPTS_PATH}/lauch_update.sh"
  fi

}

# Compare previous and new version
compare_versions () {
 
  major_current=$(echo $1 | cut -d. -f1)
  major_new=$(echo $2 | cut -d. -f1)

  if [ $major_new  -gt $major_current ]
  then 
    echo "yes"
  elif [ $major_new  -eq $major_current ]
  then
    minor_current=$(echo $1 | cut -d. -f2)
    minor_new=$(echo $2 | cut -d. -f2)
    if [ $minor_new -gt $minor_current ]
    then 
      echo "yes"
    elif [ $minor_new -eq $minor_current ]
    then 
      revision_current=$(echo $1 | cut -d. -f3)
      revision_new=$(echo $2 | cut -d. -f3)
      if [ $revision_new -gt $revision_current ]
      then 
        echo "yes"
      else 
        echo "no"
      fi
    else 
      echo "no"
    fi
  else 
    echo "no"
  fi
}

# Get current app and rootfs version
get_version () {

  if [ $1 = "appli" ]
  then 
    echo $(cat "$CURRENT_VERSIONS_FILE" | sed -n '/Application/p' | cut -d= -f2)
  elif [ $1 = "rootfs" ]
  then
    echo $(cat "$CURRENT_VERSIONS_FILE" | sed -n '/Rootfs/p' | cut -d= -f2)
  fi

}

# Verify if the version is not in invalid update file
verify_validity () {
  grep $1 $INVALID_UPDATE_FILE && echo "no" || echo "yes"
}

is_need_reboot () {
if [ $REBOOT = "1" ]
then 
  reboot
fi
}

main () {

  if [ "$(get_last_archive_name)" = "yes" ]
  then 
    if [ "$(verify_validity $APPLI_UPDATE_NAME)" = "yes" ]
    then 
      which_part
      exit 0
    else 
      exit 0
    fi
  fi
}

main
source "${SCRIPTS_PATH}/save_env"
is_need_reboot


