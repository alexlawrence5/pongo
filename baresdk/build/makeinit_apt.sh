#!/bin/bash

echo '[OK] Updating/Upgrading APT...'
sudo apt update && sudo apt upgrade -y
echo '[OK] Installing all dependencies...'
sudo apt install build-essential nasm -y
echo 'Switching build environment...'
sudo bash make.sh
