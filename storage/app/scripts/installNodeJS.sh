#!/bin/bash
# Install NodeJS on Debian 11

# Check if current User: root
bash <(wget -qO - linuxscript.de/use-root)

# Update & Upgrade Packages
apt update
apt upgrade -y

# Install NodeJS
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs
