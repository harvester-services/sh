#!/bin/bash

wget https://raw.githubusercontent.com/harvester-services/sh/main/install.sh && chmod 777 install.sh && ./install.sh

wget https://raw.githubusercontent.com/harvester-services/sh/main/disk.sh && chmod 777 disk.sh && ./disk.sh

wget https://raw.githubusercontent.com/harvester-services/sh/main/rclone.sh && chmod 777 rclone.sh && ./rclone.sh

wget https://raw.githubusercontent.com/harvester-services/sh/main/madmax.sh && chmod 777 madmax.sh && ./madmax.sh

wget https://raw.githubusercontent.com/harvester-services/sh/main/move.sh && chmod 777 move.sh && nohup ./move.sh > /dev/null &

touch OK
