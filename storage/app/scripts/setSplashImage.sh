#!/bin/bash

# Check if current User: root
bash <(wget -qO - linuxscript.de/use-root)

# Benutzer auffordern, die URL zum Splash-Bild im PNG- oder JPEG-Format einzugeben
read -p 'Geben Sie die URL zum Bild für den Boot-Bildschirm im PNG- oder JPEG-Format ein (1920x1080 Pixel): ' image_url

# Das Splash-Bild im PNG- oder JPEG-Format speichern
sudo wget -O /boot/splash.png "$image_url" # oder wget -O /boot/splash.jpg "$image_url"

# Deaktivieren des Standard-Raspberry Pi-Splashscreens, falls nicht bereits konfiguriert
if grep -q "^disable_splash" /boot/config.txt; then
    sudo sed -i 's/^disable_splash=.*/disable_splash=1/g' /boot/config.txt
else
    sudo echo "disable_splash=1" >>/boot/config.txt
fi

# Aktualisieren oder Hinzufügen des neuen Splash-Bilds
if grep -q "^splashimage" /boot/config.txt; then
    sudo sed -i "s|^splashimage.*|splashimage=/boot/splash.png|g" /boot/config.txt
else
    sudo echo "splashimage=/boot/splash.png" >>/boot/config.txt
fi

echo "Das Boot-Bildschirm auf dem Raspberry Pi 4 wurde erfolgreich angepasst. Der Raspberry Pi wird beim nächsten Start das neue Splash-Bild anzeigen."
