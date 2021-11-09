#!/bin/bash

dev=($(sudo fdisk -l | grep -o '/dev/sd[a-z]: 512 GiB' | cut -c1-8))

i=0

while [ $i -lt ${#dev[@]} ]
do

 dir='disk'$i

 sudo mkdir /mnt/$dir

 disk=${dev[i]}

 sudo mkfs.ext4 $disk

 sudo mount -t ext4 $disk /mnt/$dir

 str=$disk' /mnt/'$dir' ext4 defaults 0 0'

 sudo sed -i -e '$a'"$str" /etc/fstab

 ((i++))

done
