#!/bin/sh
ID="test"
PASS="test"
DOWNLOAD_DIR="/home/test"
SCRIPTS_PATH="/opt/scripts"
source "${SCRIPTS_PATH}/env_var" 

#Get last archive name in the FTP server. 
get_last_archive_name () {
  
  #wget --no-remove-listing "ftp://$ID:$PASS@10.5.16.130/$DOWNLOAD_DIR"
  ls $UPDATE_DIR > ".listing"
  APPLI_UPDATE_NAME=$(sort ".listing" | grep .swu | grep APPLI | tail -1)
  echo "APPLI_UPDATE_NAME=$APPLI_UPDATE_NAME" >> "$SCRIPTS_PATH/env_var"
  new_version=$(echo $APPLI_UPDATE_NAME | cut -d_ -f3)
  current_version=$(get_version "appli")
  is_new=$(compare_versions $current_version $new_version)
  echo $is_new
}

#Parse archive's name to know which partition will be updated and download archives
which_part () {
  
  #wget "ftp://$ID:$PASS@10.5.16.130/$DOWNLOAD_DIR/$APPLI_UPDATE_NAME"
  cd $UPDATE_DIR
  cpio -idv < $APPLI_UPDATE_NAME  
  cd 
  rootfs_min_version=$(cat "$UPDATE_DIR/minimal_rootfs_version.txt") 
  current_rootfs_version=$(get_version "rootfs")
  is_greater=$(compare_versions $current_rootfs_version $rootfs_min_version ) 
    
  if [ $is_greater = "yes" ]
  then
    ROOTFS_UPDATE_NAME=$(echo $APPLI_UPDATE_NAME | sed 's/APPLI/ROOTFS/')
    echo "ROOTFS_UPDATE_NAME=$ROOTFS_UPDATE_NAME" >> "$SCRIPTS_PATH/env_var"
    if [ $(verify_validity $ROOTFS_UPDATE_NAME) = "yes" ]
    then
      if [ $APP_STATE = "WAIT" ]
      then 
        #wget "ftp://$ID:$PASS@10.5.16.130/$DOWNLOAD_DIR/$ROOTFS_UPDATE_NAME"
        UPDATE_STATE="UPDATE_SYSTEM"
        source "${SCRIPTS_PATH}/lauch_update.sh"
      fi
    fi
  else
    UPDATE_STATE="UPDATE_APP"
    source "${SCRIPTS_PATH}/lauch_update.sh"
  fi
}

#Compare previous and new version
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

#Get current app and rootfs version
get_version () {

  if [ $1 = "appli" ]
  then 
    echo $(cat "$CURRENT_VERSIONS_FILE" | sed -n '/Application/p' | cut -d= -f2)
  elif [ $1 = "rootfs" ]
  then
    echo $(cat "$CURRENT_VERSIONS_FILE" | sed -n '/Rootfs/p' | cut -d= -f2)
  fi

}

#Verify if the version is not in invalid update file
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

  if [ $UPDATE_STATE = "WAIT" ]
  then 
    if [ "$(get_last_archive_name)" = "yes" ]
    then 
      if [ "$(verify_validity $APPLI_UPDATE_NAME)" = "yes" ]
      then 
        which_part
      else 
        echo "exit"
      fi
    fi
  fi
}

set > "test.txt"
main
source "${SCRIPTS_PATH}/save_env"
#is_need_reboot


