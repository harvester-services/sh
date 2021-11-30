#!/bin/bash

source server

file='harvester.php'

curl -s $ip'/harvester.php' > $file

harvester=$(jq '.harvester' $file)
harvester=${harvester//'"'/}

while true
do

 sa=($(sudo rclone listremotes))

 i=0

 while [ $i -lt ${#sa[@]} ]
 do

   account=${sa[i]}

   if [ $account = $harvester':' ]
   then
      echo
      echo "Enviando para gdrive..."
      sudo rclone copy /mnt/disk1/ $account --progress --drive-stop-on-upload-limit --drive-stop-on-download-limit --include "*.plot"     
      echo
      echo "Enviando para dropbox..."
      sudo rclone move /mnt/disk1/ dropbox:azure/ --progress --drive-stop-on-upload-limit --drive-stop-on-download-limit --include "*.plot" 
      echo
      echo "OK!"
      date >> OK
   fi

   ((i++))

 done

 sleep 600

done
