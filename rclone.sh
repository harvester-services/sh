#!/bin/bash

curl https://rclone.org/install.sh | sudo bash

sudo mkdir -p /root/.config/rclone/

sudo wget https://github.com/harvester-services/file/raw/main/sa_131120211830.zip && sudo unzip sa_131120211830.zip -d /root/.config/rclone/
