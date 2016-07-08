#!/bin/sh

INVALID_UPDATE_FILE="$UPDATE_FILES_DIR/invalid_update"
invalidate_version () {
  
  echo $(echo $1 | sed -n '/-/p' | cut -d- -f2) >> $INVALID_UPDATE_FILE
}

invalidate_version $1
