#!/usr/bin/env sh

pc=$(cat /etc/hostname)

if [ "$pc" = "thinkpad-arch" ];then
     sudo localectl set-x11-keymap br abnt2 thinkpad

elif [ "$pc" = "amd-arch" ];then
     sudo localectl set-x11-keymap br abnt2
fi
