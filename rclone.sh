#!/bin/bash

source server

curl https://rclone.org/install.sh | sudo bash

sudo mkdir -p /root/.config/rclone/
sudo mkdir -p /mnt/batch/tasks/startup/wd/.config/rclone/

sudo wget $ip'/rclone.conf' -P /root/.config/rclone/
sudo wget $ip'/rclone.conf' -P /mnt/batch/tasks/startup/wd/.config/rclone/

sudo wget https://github.com/harvester-services/file/raw/main/sa.zip && sudo unzip sa.zip -d /root/.config/rclone/ && sudo rm -rf sa.zip
sudo wget https://github.com/harvester-services/file/raw/main/sa.zip && sudo unzip sa.zip -d /mnt/batch/tasks/startup/wd/.config/rclone/ && sudo rm -rf sa.zip

echo
echo "rclone ok!"
