#!/bin/sh
# invalidate_update.sh - A shell script to invalidate versions

# Write archive's name in invalid_update file
invalidate_version () {
  
  echo $1 >> $INVALID_UPDATE_FILE
}

invalidate_version $1
