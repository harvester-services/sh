#!/bin/bash

user=($(users))
user=$user':'

while true
do

 sa=($(sudo rclone listremotes))

 i=0

 while [ $i -lt ${#sa[@]} ]
 do

   account=${sa[i]}

   if [ $account = $user ]
   then
      echo
      echo $account
      echo "Enviando para dropbox..."
      sudo rclone copy /mnt/disk1/ dropbox:azure/ --progress --drive-stop-on-upload-limit --drive-stop-on-download-limit --include "*.plot"
      echo
      echo "Enviando para gdrive..."
      sudo rclone move /mnt/disk1/ $account --progress --drive-stop-on-upload-limit --drive-stop-on-download-limit --include "*.plot"
      echo
      echo "OK!"
   fi

   ((i++))

 done

 sleep 600

done
