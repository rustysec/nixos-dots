#!/bin/bash

if [ -z $1 ]; then
    sudo nixos-rebuild --flake ".#$(hostname)" switch
else
    sudo nixos-rebuild --flake ".#$1" switch
fi
