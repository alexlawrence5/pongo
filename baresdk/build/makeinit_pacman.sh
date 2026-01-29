#!/bin/bash

echo '[OK] Updating/Upgrading APT...'
sudo pacman -Syu
echo '[OK] Installing all dependencies...'
sudo pacman -S build-essential nasm -y
echo 'Switching build environment...'
sudo bash make.sh
