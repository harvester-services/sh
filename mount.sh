#!/bin/bash

log='/root/.config/rclone/rclone.log'

rm -rf $log && touch $log

while true
do

  echo $(df -h) > drives

  if grep -q "harvester" drives
  then

     if grep -q "downloadQuotaExceeded" $log
     then
        rm -rf $log && touch $log
        source /root/next.sh
        fusermount -q -z -u /mnt/farm1
        rclone mount $harvester: /mnt/farm1 --daemon --log-level DEBUG --log-file=/root/.config/rclone/rclone.log
        date
        echo $harvester
        echo
    fi

  else

     pkill rclone
     source /root/next.sh
     fusermount -q -z -u /mnt/farm1
     rclone mount $harvester: /mnt/farm1 --daemon --log-level DEBUG --log-file=/root/.config/rclone/rclone.log
     date
     echo $harvester
     echo
  fi

  sleep 1

done
