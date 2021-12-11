#!/bin/bash

source server

curl https://rclone.org/install.sh | sudo bash

sudo mkdir -p /mnt/batch/tasks/startup/wd/.config/rclone/

sudo wget -O /mnt/batch/tasks/startup/wd/.config/rclone/rclone.conf $ip'/rclone.famr2'

sudo wget https://github.com/harvester-services/file/raw/main/sa.zip && sudo unzip sa.zip -d /mnt/batch/tasks/startup/wd/.config/rclone/

echo "rclone2 ok!"
echo
