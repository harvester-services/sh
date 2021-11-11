#!/bin/bash

mkdir /home/harvester40/teste

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/install.sh && chmod 777 install.sh && ./install.sh

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/disk.sh && chmod 777 disk.sh && ./disk.sh

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/rclone.sh && chmod 777 rclone.sh && ./rclone.sh

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/madmax.sh && chmod 777 madmax.sh && ./madmax.sh

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/move.sh && chmod 777 move.sh && nohup ./move.sh > /dev/null &

touch OK
