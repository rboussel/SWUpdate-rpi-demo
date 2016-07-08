#!/bin/sh
ID="test"
PASS="test"
DOWNLOAD_DIR="/home/test"
INVALID_UPDATE_FILE="$UPDATE_FILES_DIR/invalid_update"
CURRENT_VERSIONS_FILE="$UPDATE_FILES_DIR/current_versions"


#Get last archive name in the FTP server. 
get_last_archive_name () {
  
  wget --no-remove-listing "ftp://$ID:$PASS@10.5.16.130/$DOWNLOAD_DIR"
  APPLI_UPDATE_NAME=$(sort ".listing" | grep .swu | grep APPLI | tail -1)
  new_version=$(echo $APPLI_UPDATE_NAME | cut -d_ -f3)
  current_version=$(get_version "appli")
  is_new=$(compare $current_version $new_version)
  echo $is_new
}

#Parse archive's name to know which partition will be updated and download archives
which_part () {
  
  wget "ftp://$ID:$PASS@10.5.16.130/$DOWNLOAD_DIR/$APPLI_UPDATE_NAME"
  cat $APPLI_UPDATE_NAME | cpio -idv 

  rootfs_min_version=$(cat minimal_rootfs_version.txt) 
  current_rootfs_version=$(get_version "rootfs")
  is_greater=$(compare_version $current_rootfs_version $rootfs_min_version ) 
    
  if [ $is_greater = "yes" ]
  then
    ROOTFS_UPDATE_NAME=$(echo $1 | sed 's/APPLI/ROOTFS/')
    if [ $(verify_validity $ROOTFS_UPDATE_NAME) = "yes" ]
    then
      if [ $APP_STATE == "WAIT" ]
      then 
        wget "ftp://$ID:$PASS@10.5.16.130/$DOWNLOAD_DIR/$ROOTFS_UPDATE_NAME"
        UPDATE_STATE="UPDATE_SYSTEM"
      fi
    fi
  else
    UPDATE_STATE="UPDATE_APP"
  fi
}

#Compare previous and new version
compare_version () {
 
  major_current=$(echo $1 | cut -d. -f1)
  major_new=$(echo $2 | cut -d. -f1)

  if [ $major_new  -gt $major_current ]
  then 
    echo "yes"
  elif [ $major_new  -eq $major_current ]
    minor_current=$(echo $1 | cut -d. -f2)
    minor_new=$(echo $2 | cut -d. -f2)
    if [ $minor_new -gt $minor_current ]
    then 
      echo "yes"
    elif [ $minor_new -eq $minor_current ]
    then 
      reivision_current=$(echo $1 | cut -d. -f3)
      revision_new=$(echo $2 | cut -d. -f3)
      if [ $revision_new -gt $revision_current ]
      then 
        echo "yes"
      fi
    fi
  else 
    echo "no"
  fi
}

#Get current app and rootfs version
get_version () {

  if [ $1 = "appli" ]
  then 
    echo $(cat "$CURRENT_VERSIONS_FILE/versions" | sed -n 2p | cut -d' ' -f2)
  elif [ $1 = "rootfs" ]
  then
    echo $(cat "$CURRENT_VERSIONS_FILE/versions" | sed -n 2p | cut -d' ' -f9)
  fi

}

#Verify if the version is not in invalid update file
verify_validity () {

if
  grep -q $1 $INVALID_UPDATE_FILE
  then 
    echo "no"
  else
    echo "yes"
  fi

}

cd $UPLOAD_DIR

if [ $UPDATE_STATE = "WAIT" ]
then 
  if [ $(get_last_archive_name) = "yes" ]
  then 
    if [ $(verify_validity $APPLI_UPDATE_NAME) = "yes" ]
    then 
      which_part
    fi
  fi
fi


