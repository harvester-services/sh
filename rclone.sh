#!/bin/bash

curl https://rclone.org/install.sh | sudo bash

sudo mkdir -p /root/.config/rclone/

sudo wget https://github.com/harvester-services/file/raw/f5004716a3d838020d00406dc33dcd6913f96b8c/sa.zip && unzip sa.zip -d /root/.config/rclone/
