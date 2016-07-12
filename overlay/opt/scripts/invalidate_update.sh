#!/bin/sh

INVALID_UPDATE_FILE="$UPDATE_DIR/invalid_update"
invalidate_version () {
  
  echo $1 >> $INVALID_UPDATE_FILE
}

invalidate_version $1
