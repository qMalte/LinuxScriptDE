#!/bin/bash
# Ensure that logged in as Administrator (root)

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
        fi

    else
        echo ERR_MSG
    fi

fi
