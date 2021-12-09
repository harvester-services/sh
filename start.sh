#!/bin/bash

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/server

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/install.sh && chmod 777 install.sh && ./install.sh

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/disk.sh && chmod 777 disk.sh && ./disk.sh

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/rclone.sh && chmod 777 rclone.sh && ./rclone.sh

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/madmax.sh && chmod 777 madmax.sh && ./madmax.sh

wget -q https://raw.githubusercontent.com/harvester-services/sh/main/default.sh && chmod 777 default.sh && nohup ./default.sh > /dev/null &

touch OK
