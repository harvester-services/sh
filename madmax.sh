#!/bin/bash

git clone https://github.com/madMAx43v3r/chia-plotter.git

cd chia-plotter

git submodule update --init

./make_devel.sh

sudo mv build/chia_plot /usr/bin

wget -p https://raw.githubusercontent.com/harvester-services/sh/main/chia_plot.sh && chmod 777 chia_plot.sh && nohup ./chia_plot.sh > /dev/null &

echo "madmax ok!"
