#!/bin/sh
# get_archive_name.sh - A shell script to get new archive 

# Variables
SCRIPTS_PATH="/opt/scripts"
SCRIPT_ENVIRONNEMENT="$SCRIPTS_PATH/env_var"
is_archive=""

# Get last archive name in the FTP server. 
get_last_archive_name () {
 
  if [ "$UPDATE_STATE" = "WAIT" ] 
  then 
    #wget --no-remove-listing "ftp://$ID:$PASS@10.5.16.130/$DIR_DOWNLOAD"
    ls $DIR_UPDATE > "$DIR_UPDATE/.listing"
    APPLI_UPDATE_NAME=$(sort "$DIR_UPDATE/.listing" | grep .swu | grep APP | tail -1)
    if [ "$APPLI_UPDATE_NAME" ]; then 
      echo "APPLI_UPDATE_NAME=$APPLI_UPDATE_NAME" >> $SCRIPT_ENVIRONNEMENT
      UPDATE_STATE="GET_APP_ARCHIVE_NAME"
      source $SCRIPT_SAVE_ENVIRONNEMENT
      else exit 0; fi 
  fi
  # Verify that new version is greater than the current version 
  new_version=$(echo $APPLI_UPDATE_NAME | cut -d_ -f3)
  current_version=$(get_version "appli")
  is_archive=$(compare_versions $current_version $new_version)
}

# Parse archive's name to know which partition will be updated and download archives
which_part () {
 
  # Get application archive
  if [ "$UPDATE_STATE" = "GET_APP_ARCHIVE_NAME" ]
  then 
    #wget "ftp://$ID:$PASS@10.5.16.130/$DIR_DOWNLOAD/$APPLI_UPDATE_NAME"
    cd $DIR_UPDATE
    cpio -idv < $APPLI_UPDATE_NAME  
    UPDATE_STATE="GET_APP_ARCHIVE" 
    APPLI_UPDATE_NAME=$(ls | sort | grep .swu | grep APP | tail -1)
   source $SCRIPT_SAVE_ENVIRONNEMENT
    cd
  fi
    # Verify if new rootfs is needed
    rootfs_min_version=$(cat $FILE_MINIMAL_ROOTFS_VERSION) 
    current_rootfs_version=$(get_version "rootfs")
    is_greater=$(compare_versions $current_rootfs_version $rootfs_min_version ) 
    
  if [ "$is_greater" = "yes" ]
  then
    if [ "$UPDATE_STATE" = "GET_APP_ARCHIVE" ]
    then 
      # Get rootfs name
      ROOTFS_UPDATE_NAME=$(sort "$DIR_UPDATE/.listing" | grep .swu | grep ROOTFS | tail -1)
      if [ "$ROOTFS_UPDATE_NAME" ]; then 
        echo "ROOTFS_UPDATE_NAME=$ROOTFS_UPDATE_NAME" >> "$SCRIPTS_PATH/env_var"
        UPDATE_STATE="GET_ROOTFS_NAME"
        source $SCRIPT_SAVE_ENVIRONNEMENT
      else 
        exit 0
      fi
    fi
    
    if [ "$UPDATE_STATE" = "GET_ROOTFS_NAME" ]
    then 
      # Verify rootfs version validity
      if [ $(verify_validity $ROOTFS_UPDATE_NAME) = "yes" ]
      then
        # If the application version is not the previous, download the new rootfs, else we do not need it,
        # it is in the inactive rootfs partition
        if [ "$APP_STATE" = "WAIT" ]
        then 
          #wget "ftp://$ID:$PASS@10.5.16.130/$DIR_DOWNLOAD/$ROOTFS_UPDATE_NAME"
          UPDATE_STATE="UPDATE_SYSTEM"
        else 
          UPDATE_STATE="UPDATE_APP"
        fi
      else 
         # If rootfs invalid wait next update
         UPDATE_STATE="WAIT"
      fi
      source $SCRIPT_SAVE_ENVIRONNEMENT
    fi
  else  
    UPDATE_STATE="UPDATE_APP"
    source $SCRIPT_SAVE_ENVIRONNEMENT
  fi

  if [ $UPDATE_STATE = "UPDATE_APP" -o $UPDATE_STATE = "UPDATE_SYSTEM" ]
  then 
    source $SCRIPT_LAUNCH_UPDATE
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
    echo $(cat "$FILE_CURRENT_VERSIONS" | sed -n '/Application/p' | cut -d= -f2)
  elif [ $1 = "rootfs" ]
  then
    echo $(cat "$FILE_CURRENT_VERSIONS" | sed -n '/Rootfs/p' | cut -d= -f2)
  fi

}

# Verify if the version is not in invalid update file
verify_validity () {
  grep $1 $FILE_INVALID_UPDATE && echo "no" || echo "yes"
}

is_need_reboot () {
if [ $REBOOT = "1" ]
then 
  reboot
fi
}

main () {

  get_last_archive_name
  if [ "$is_archive" = "yes" ]
  then 
    is_valide=$(verify_validity $APPLI_UPDATE_NAME)
    if [ "$is_valide" = "yes" ]
    then 
      which_part
      exit 0
    else
      UPDATE_STATE="WAIT"
      exit 0
    fi
  fi
}

source $SCRIPT_ENVIRONNEMENT 
main
source $SCRIPT_SAVE_ENVIRONNEMENT 
#is_need_reboot


