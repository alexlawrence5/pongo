echo 'Updating and upgrading APT...'
sudo apt update
sudo apt upgrade
echo 'Installing dependencies...'
sudo apt install nasm
sudo apt install make
echo 'Building system...'
make
echo 'Built.'
