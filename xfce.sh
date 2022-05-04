#!/bin/bash

systemctl --user enable pipewire-pulse.service

systemctl --user enable pipewire.service

systemctl --user --now enable wireplumber.service

git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si --noconfirm

git clone https://aur.archlinux.org/aic94xx-firmware.git && cd aic94xx-firmware && makepkg -sri  --noconfirm
git clone https://aur.archlinux.org/wd719x-firmware.git && cd wd719x-firmware && makepkg -sri --noconfirm
git clone https://aur.archlinux.org/upd72020x-fw.git && cd upd72020x-fw && makepkg -sri --noconfirm

echo -e 'dxgi.maxDeviceMemory = 1024\ndxvk.numAsyncThreads = 4\ndxvk.numCompilerThreads = 4' | tee ~/.config/dxvk.conf && echo -e '\nDXVK_CONFIG_FILE=/home/bn/.config/dxvk.conf\nDXVK_ASYNC=1\nLFX=1' | sudo tee -a /etc/environment

git clone http://github.com/eusouobn/xfce
cd xfce
tar -xvf xfce-perchannel-xml.tar.xz
rm -r /home/bn/.config/xfce4/xfconf/xfce-perchannel-xml

mv xfce-perchannel-xml /home/bn/.config/xfce4/xfconf/

sudo rm -r /home/bn/xfce

exit
