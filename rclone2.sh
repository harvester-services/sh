#!/bin/bash

source server

curl https://rclone.org/install.sh | sudo bash

sudo mkdir -p /mnt/batch/tasks/startup/wd/.config/rclone/

sudo wget -O rclone.conf $ip'/rclone.farm2' -P /mnt/batch/tasks/startup/wd/.config/rclone/

sudo wget https://github.com/harvester-services/file/raw/main/sa.zip && sudo unzip sa.zip -d /mnt/batch/tasks/startup/wd/.config/rclone/

echo rclone2.sh ok!
