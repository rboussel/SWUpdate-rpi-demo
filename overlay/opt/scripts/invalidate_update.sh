#!/bin/sh
# invalidate_update.sh - A shell script to invalidate versions
INVALID_UPDATE_FILE="$UPDATE_DIR/invalid_update"

# Echo archive's name in invalid_update file
invalidate_version () {
  
  echo $1 >> $INVALID_UPDATE_FILE
}

invalidate_version $1
