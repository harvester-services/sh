#!/bin/bash

while true
do

 sa=($(rclone listremotes))

 i=0

 while [ $i -lt ${#sa[@]} ]
 do

   account=${sa[i]}

   if [[ $account =~ "harvester" ]]
   then
      echo
      echo $account
      rclone copy dropbox:migration1/ $account --transfers=2 --progress --drive-stop-on-upload-limit --drive-stop-on-download-limit
   fi

   ((i++))

 done

 sleep 60

done
