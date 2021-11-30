  GNU nano 5.6.1                                                                   mount.sh
#!/bin/bash

log='/root/.config/rclone/rclone.log'

rm -rf $log && touch $log

pkill rclone
fusermount -q -u /mnt/farm1

if ! pgrep rclone > /dev/null
then
   echo
   date
   echo 'RCLONE não está aberto'
   source /root/next.sh
   rclone mount $harvester: /mnt/farm1 --daemon --log-level DEBUG --log-file=/root/.config/rclone/rclone.log
   echo 'Iniciado com '$harvester
   echo
fi

while true
do

  if grep -q "downloadQuotaExceeded" $log
  then
     rm -rf $log && touch $log
     pkill rclone
     fusermount -q -u /mnt/farm1
     source /root/next.sh
     rclone mount $harvester: /mnt/farm1 --daemon --log-level DEBUG --log-file=/root/.config/rclone/rclone.log
     date
     echo $harvester
     echo
  fi

  sleep 1

done
