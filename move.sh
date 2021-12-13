#!/bin/bash

source server

file='harvester.php'

curl -s $ip'/harvester.php' > $file

harvester=$(jq '.harvester' $file)
harvester=${harvester//'"'/}

account=$harvester':'

echo
echo $account
echo

while true
do   

 sudo rclone move /mnt/disk1/ $account --drive-stop-on-upload-limit --drive-stop-on-download-limit --include "*.plot"
 echo "Verificando plots..."

 echo
 sudo rclone size $account
 echo
 df -h
 echo 

 sleep 600

done
