#!/bin/bash

sudo pacman -S vulkan-intel vulkan-icd-loader vulkan-mesa-layers libva-intel-driver lib32-mesa lib32-vulkan-intel  lib32-vulkan-icd-loader lib32-libva-intel-driver lib32-vulkan-mesa-layers mesa-demos xorg-xdpyinfo mesa-utils --noconfirm

sudo pacman -S xfce4-whiskermenu-plugin xfce4-pulseaudio-plugin xfce4-screenshooter ristretto mousepad galculator xfce4-screenshooter ristretto audacious --noconfirm

sudo pacman -S plank firefox firefox-i18n-pt-br ttf-ubuntu-font-family plank hardinfo audacious bluez blueman bluez-utils zenity --noconfirm

sudo pacman -S xarchiver file-roller tar zip gzip lzip lzop p7zip lrzip bzip2 zip unzip unrar p7zip unrar cpio thunar-archive-plugin --noconfirm

sudo pacman -S simplescreenrecorder ffmpeg psensor gimp gnome-disk-utility frei0r-plugins ntfs-3g exfatprogs gsmartcontrol obs-studio uget qbittorrent papirus-icon-theme telegram-desktop gamemode fatsort mpv audacious inkscape audacity kdenlive libreoffice-fresh-pt-br alsa-firmware alsa-utils a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore gstreamer gst-plugins-base gst-plugins-base-libs gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb git go fuse2 base-devel movit ttf-dejavu ttf-liberation noto-fonts noto-fonts-emoji  ttf-roboto ttf-roboto-mono ttf-opensans --noconfirm

sudo pacman -S wine-staging wine-mono wine-gecko gamemode lib32-gamemode giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader vkd3d lib32-vkd3d lib32-gnutls winetricks --noconfirm

sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d && sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d && sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d

sudo sed -i 12d /etc/profile.d/freetype2.sh && echo -e 'export FREETYPE_PROPERTIES="truetype:interpreter-version=40"' | sudo tee -a /etc/profile.d/freetype2.sh

echo -e 'vm.dirty_background_ratio = 2 \nvm.dirty_ratio = 5' | sudo tee /etc/sysctl.conf && sysctl -p

echo -e 'Section "Device"\n Identifier "Intel Graphics"\n Driver "Intel"\n Option "TearFree" "true"\nEndSection' | sudo tee /etc/X11/xorg.conf.d/20-intel.conf

sudo truncate -s 0 /swapfile && sudo chattr +C /swapfile && sudo btrfs property set /swapfile compression none && sudo fallocate -l 4096M /swapfile && sudo chmod 600 /swapfile && sudo mkswap /swapfile && sudo swapon /swapfile && echo -e '/swapfile none swap defaults 0 0\n' | sudo tee -a /etc/fstab

echo -e 'net.ipv4.ping_group_range = 1000 1000' | sudo tee -a /etc/sysctl.d/60-mysql.conf

sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.bak && sudo sed -i '120c\autologin-user=bn' /etc/lightdm/lightdm.conf

sh xfce.sh
