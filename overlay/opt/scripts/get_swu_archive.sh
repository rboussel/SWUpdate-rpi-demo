#!/bin/sh

SWU_ARCHIVE_DIR="/DATA/update/"
INVALID_UPDATE_FILE="/etc/update_files/invalid_update.txt"

get_archive () {
  echo "swupdate_1.2_CRITICAL.swu"
  #Download archive 
  #get archive name
  #echo $archive_name
}

verify_version_invalidity () {
  
  downloded_version=$(echo $1 | sed -n '/-/p' | cut -d- -f2)
  if 
    grep -q $downloaded_version $INVALID_UPDATE_FILE 
  then 
    exit 0
  else
    ./lauch_update $1
    #change /etc/hwrevision version
  fi   
}

archive_name=$(get_archive)
verify_version_invalidity $archive_name


