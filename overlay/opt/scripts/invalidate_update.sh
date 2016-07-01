#!/bin/sh

invalidate_version () {
  
  echo $(echo $1 | sed -n '/-/p' | cut -d- -f2) >> /etc/update_files/invalid_update.txt  

}

invalidate_version $1
