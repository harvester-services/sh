#!/bin/bash

git clone https://github.com/madMAx43v3r/chia-plotter.git

cd chia-plotter

git submodule update --init

./make_devel.sh

sudo mv build/chia_plot /usr/bin

wget -p https://raw.githubusercontent.com/harvester-services/sh/main/chia_plot.sh

#nohup sudo chia_plot -n -1 -f a44886170ea57821f264b77ba1f1a1310b161fbe4dcc99a4e1e4bffb114fbc239464f23ef32655ba7fa9e620513403f8 -c xch1446gm3zlma64flhn3hmacdv2xy77puthp7z9p57a08s64k6x57ws4cmylj -t /mnt/disk0/ -2 /mnt/disk0/ -d /mnt/disk1/ -r 4 -u 256 -v 128 > /dev/null &



echo "madmax ok!"
