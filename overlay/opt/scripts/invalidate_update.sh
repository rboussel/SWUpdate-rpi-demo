#!/bin/sh
# invalidate_update.sh - A shell script to invalidate versions

# Write archive's name in invalid_update file
invalidate_version () {
  
  echo "$1" >> $FILE_INVALID_UPDATE
}

invalidate_version $1
