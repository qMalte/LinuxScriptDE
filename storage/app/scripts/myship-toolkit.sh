#!/bin/bash
# MyShip - Toolkit

update_dep() {
  ensurePermissions
  apt update
  apt upgrade -y
}

install_tools() {
  ensurePermissions
  update_dep
  if command -v mysql &>/dev/null; then
    echo "MySQL ist bereits installiert."
  else
    bash <(wget -qO - linuxscript.de/install-mariadb)
  fi
  if command -v node &>/dev/null; then
    echo "NodeJS ist bereits installiert."
  else
    bash <(wget -qO - linuxscript.de/install-nodejs)
  fi
  if systemctl list-units --type=service | grep -q 'signalk.service'; then
    echo "SignalK ist bereits installiert."
  else
    bash <(wget -qO - linuxscript.de/install-signalk)
  fi
  if command -v curl &>/dev/null; then
    echo "Curl ist bereits installiert."
  else
    apt install curl
  fi
}

ensurePermissions() {
  ERR_MSG="[ERROR] Das Script muss als Administrator ausgeführt werden."

  # Check if current User: root
  if [ "$EUID" -ne 0 ]; then

    # Check, if sudo installed
    if which sudo >/dev/null; then

      # Check, if current User sudo Permissions
      if sudo -v >/dev/null 2>&1; then
        sudo su
      else
        echo ERR_MSG
        exit 1
      fi

    else
      echo ERR_MSG
      exit 1
    fi

  fi
}

refresh_script() {
  local URL="linuxscript.de/myship"
  local TARGET_DIR="/usr/local/bin"
  local TARGET_FILE="myship"

  if [[ $EUID -ne 0 ]]; then
    echo "Dieses Skript muss mit root-Berechtigungen ausgeführt werden."
    return 1
  fi

  if curl -o "$TARGET_DIR/$TARGET_FILE" -L "$URL"; then
    echo "Die Datei wurde erfolgreich heruntergeladen und im Verzeichnis $TARGET_DIR gespeichert."
    chmod +x "$TARGET_DIR/$TARGET_FILE"
  else
    echo "Fehler beim Herunterladen oder Speichern der Datei."
    return 1
  fi
}

checkIfOnline() {
  local host="127.0.0.1"
  local port="1883"
  local timeout_seconds="60"
  local sleep_interval=2

  local end_time=$((SECONDS + timeout_seconds))

  echo "Überprüfe den Status des Servers..."

  while [ $SECONDS -lt $end_time ]; do
    if timeout 1 bash -c "exec 3<> /dev/tcp/$host/$port" &>>"/var/log/myship"; then
      echo "Der Server ist gestartet."
      return 0
    fi
    echo -n "."
    sleep "$sleep_interval"
  done

  echo "Fehler: Der Server wurde nicht wie erwartet gestartet."
  return 1
}

updateCore() {

  local directory="/opt/Server"

  ensurePermissions
  install_tools

  if command -v pm2 &>/dev/null; then
    echo "pm2 ist bereits installiert."
  else
    npm i -g pm2
  fi

  if [ -d "$directory" ]; then
    cd "$directory" || return

    if [ -d ".git" ]; then
      git pull
    else
      echo "Das Verzeichnis '$directory' ist kein Git-Repository."
    fi

    cd - || return
  else
    echo "Das Verzeichnis '$directory' existiert nicht."
  fi

  echo "Der Server wird neugestartet."
  pm2 restart MyShipServer

  if checkIfOnline; then
    echo "Der Server ist gestartet."
  fi

}

generateClientToken() {
  local comment
  read -p "Bitte gebe eine Bezeichnung für den Client ein: " comment
  local adminFlag
  read -n 1 -p "Soll das Admin-Flag für den Token gesetzt werden? (1 -> Ja - 0 -> Nein) " adminFlag
  echo ""

  if [ "$adminFlag" -ne 0 ] && [ "$adminFlag" -ne 1 ]; then
    echo "Ungültige Eingabe."
    wait
  fi

  if checkIfOnline; then
    node /opt/Server/dist/scripts/generateClientTokenScript.js "$comment" "$adminFlag"
  else
    echo "Der Server muss gestartet sein, um einen neuen Token zu generieren."
  fi

}

wait() {
  echo "Bitte drücken Sie eine beliebige Taste, um zum Menü zurückzukehren."
  read -n 1
  showMenu
}

showMenu() {

  clear

  HEADER_COLOR='\033[1;34m'
  RESET_COLOR='\033[0m'

  echo ""
  echo -e "${HEADER_COLOR}"
  echo "  __  __        _____ _     _          _______          _ _    _ _   "
  echo " |  \/  |      / ____| |   (_)        |__   __|        | | |  (_) |  "
  echo " | \  / |_   _| (___ | |__  _ _ __ ______| | ___   ___ | | | ___| |_ "
  echo " | |\/| | | | |\___ \| '_ \| | '_ \______| |/ _ \ / _ \| | |/ / | __|"
  echo " | |  | | |_| |____) | | | | | |_) |     | | (_) | (_) | |   <| | |_ "
  echo " |_|  |_|\__, |_____/|_| |_|_| .__/      |_|\___/ \___/|_|_|\_\_|\__|"
  echo "          __/ |              | |                                      "
  echo "         |___/               |_|                                      "
  echo -e "${RESET_COLOR}"
  echo ""
  echo "===== Menü ====="
  echo "1. Update: Toolkit"
  echo "2. Update: Pakete"
  echo "3. Update: Core-Server"
  echo "4. Installation nötiger Programme (MySQL, NodeJS, SignalK)"
  echo "5. Aktion: Core-Server - Neuen Client-Token generieren"
  echo "Q. Verlassen"
  echo "================"

  echo ""
  local choice
  read -n 1 -p "Bitte wähle eine Option: " choice

  clear

  case $choice in
  1)
    refresh_script
    wait
    ;;
  2)
    update_dep
    wait
    ;;
  3)
    updateCore
    wait
    ;;
  4)
    install_tools
    wait
    ;;
  5)
    generateClientToken
    wait
    ;;
  "q")
    exit 0
    ;;
  *)
    showMenu
    ;;
  esac
}

# Start
showMenu
