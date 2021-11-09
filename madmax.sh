#!/bin/bash

git clone https://github.com/madMAx43v3r/chia-plotter.git

cd chia-plotter

git submodule update --init

./make_devel.sh

sudo mv build/chia_plot /usr/bin
