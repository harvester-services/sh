#!/bin/bash

sudo rclone size default:
echo

while true
do

 echo "Enviando para gdrive..."
 sudo rclone copy /mnt/disk1/ default: --progress --drive-stop-on-upload-limit --drive-stop-on-download-limit --include "*.plot"     
 echo
 echo "move2 OK!"

 sleep 60

done
