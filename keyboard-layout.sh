#!/bin/bash
layout=$(setxkbmap -query | grep layout | awk '{print $2}')
case $layout in
    "us") echo "ENG" ;;
    "ru") echo "RUS" ;;
    *) echo "$layout" ;;
esac