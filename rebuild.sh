#!/bin/bash

sudo nixos-rebuild --flake ".#$1" switch
