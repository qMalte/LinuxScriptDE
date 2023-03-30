#!/bin/bash
# Install SignalK on Debian 11

# Check if current User: root
bash <(wget -qO - linuxscript.de/use-root)

# Update & Upgrade Packages
apt update
apt upgrade -y

if command -v node >/dev/null 2>&1; then
    # Install SignalK
    sudo npm install -g signalk-server
    sudo signalk-server-setup
else
    bash <(wget -qO - linuxscript.de/install-nodejs)
fi
