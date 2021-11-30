#!/bin/bash

source /root/server

file=$(openssl rand -hex 12)

curl -s $ip'/harvester.php' > $file

harvester=$(jq '.harvester' $file)
harvester=${harvester//'"'/}

rm -rf $file
