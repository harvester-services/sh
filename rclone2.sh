#!/bin/bash

source server

curl https://rclone.org/install.sh | sudo bash

sudo mkdir -p /mnt/batch/tasks/startup/wd/.config/rclone/

sudo wget -O /mnt/batch/tasks/startup/wd/.config/rclone/rclone.conf $ip'/rclone.farm2'

sudo wget $ip'/sa.zip' && sudo unzip sa.zip -d /mnt/batch/tasks/startup/wd/.config/rclone/

echo "rclone2 ok!"
echo
