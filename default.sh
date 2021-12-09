#!/bin/bash

while true
do

 echo "Enviando para gdrive..."
 sudo rclone copy /mnt/disk1/ default: --progress --drive-stop-on-upload-limit --drive-stop-on-download-limit --include "*.plot"     
 echo
 echo "OK!"

 sleep 600

done
