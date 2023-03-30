#!/bin/bash

# Check if current User: root
bash <(wget -qO - linuxscript.de/use-root)

# MariaDB Server Installation
sudo apt update
sudo apt install -y mariadb-server

# Konfiguration ändern
sudo sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Benutzername und Passwort abfragen
read -p 'Geben Sie den gewünschten Benutzernamen für den Administrator-Account ein: ' username
read -sp 'Geben Sie das Passwort für den Administrator-Account ein: ' password

# Benutzer erstellen
sudo mysql -e "CREATE USER '$username'@'%' IDENTIFIED BY '$password'; GRANT ALL PRIVILEGES ON *.* TO '$username'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

echo "MariaDB Server Installation abgeschlossen und Konfiguration geändert. Benutzer '$username' mit Host '%' und allen Rechten inklusive GRANT Flag wurde erstellt."
