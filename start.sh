#!/bin/bash

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/server

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/install.sh && chmod 777 install.sh && ./install.sh

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/disk.sh && chmod 777 disk.sh && ./disk.sh

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/rclone.sh && chmod 777 rclone.sh && ./rclone.sh
#wget -q https://raw.githubusercontent.com/harvester-services/sh/main/rclone2.sh && chmod 777 rclone2.sh && ./rclone2.sh

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/madmax.sh && chmod 777 madmax.sh && ./madmax.sh

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/move.sh && chmod 777 move.sh && nohup ./move.sh > /dev/null &
#wget -q https://raw.githubusercontent.com/harvester-services/sh/main/move2.sh && chmod 777 move2.sh && nohup ./move2.sh &

touch OK
