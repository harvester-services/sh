#!/bin/bash

log='/root/.config/rclone/rclone.log'

while true
do

  if grep -q "downloadQuotaExceeded" $log
  then
     rm -rf $log
     source /root/next.sh
     fusermount -q -u /mnt/farm1
     rclone mount $harvester: /mnt/farm1 --log-level DEBUG --log-file=/root/.config/rclone/rclone.log
     date
     echo $harvester
     echo
  fi

  sleep 1

done
