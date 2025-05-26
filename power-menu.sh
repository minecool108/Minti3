#!/bin/bash
action=$(zenity --list \
    --title="Power Management" \
    --column="Action" \
    "Shutdown" \
    "Reboot" \
    "Suspend" \
    "Logout")

case $action in
    "Shutdown") systemctl poweroff ;;
    "Reboot") systemctl reboot ;;
    "Suspend") systemctl suspend ;;
    "Logout") i3-msg exit ;;
esac