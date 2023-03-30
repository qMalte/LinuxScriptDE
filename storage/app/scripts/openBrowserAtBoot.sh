#!/bin/bash

# Check if current User: root
bash <(wget -qO - linuxscript.de/use-root)

# Überprüfen, ob Chromium installiert ist, und falls nicht, installieren
if ! [ -x "$(command -v chromium-browser)" ]; then
    sudo apt-get update
    sudo apt-get install -y chromium-browser
fi

# Abfrage der Web-Adresse
read -p 'Geben Sie die IP-Adresse oder Domain inklusive Port ein (ohne http oder https): ' web_address

# Kommentieren Sie alle bestehenden Einträge in der Autostart-Datei aus
sudo sed -i 's/^@/#@/' /etc/xdg/lxsession/LXDE-pi/autostart

# Konfigurationsdatei erstellen
cat <<EOF | sudo tee -a /etc/xdg/lxsession/LXDE-pi/autostart
@chromium-browser --noerrdialogs --kiosk --disable-translate --no-first-run --disable-infobars --disable-features=TranslateUI --remote-debugging-port=9222 --disable-extensions --disable-component-update --disable-sync --disable-default-apps --autoplay-policy=no-user-gesture-required --disable-breakpad --disable-crash-reporter --disable-session-crashed-bubble --disable-tab-switcher --disable-gpu --disable-gpu-compositing --enable-logging --v=1 --kiosk $web_address
EOF

echo "Chromium wurde installiert, alle vorherigen Einträge in der Konfigurationsdatei wurden auskommentiert. Die Konfigurationsdatei wurde aktualisiert, um $web_address im Kiosk-Modus ohne Mauszeiger und mit deaktivierter Hardwarebeschleunigung zu öffnen."
