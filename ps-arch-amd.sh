#!/bin/bash

pacman -S base-devel git nano pacman-contrib btrfs-progs sudo amd-ucode grub efibootmgr --noconfirm

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak && reflector --country Brazil --sort rate --save /etc/pacman.d/mirrorlist

cp /etc/pacman.conf /etc/pacman.conf.bak && sed -i '37c\ParallelDownloads = 16' /etc/pacman.conf

cp /etc/pacman.conf /etc/pacman.conf.bak && sed -i '93c\[multilib]' /etc/pacman.conf && sudo sed -i '94c\Include = /etc/pacman.d/mirrorlist' /etc/pacman.conf && pacman -Syyyuu

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

hwclock --systohc

mv /etc/locale.gen /etc/locale.gen.bak

echo -e 'pt_BR.UTF-8 UTF-8' | tee /etc/locale.gen

locale-gen

echo -e 'LANG=pt_BR.UTF-8' | tee /etc/locale.conf

echo -e 'amd-arch' | tee /etc/hostname

echo -e "127.0.0.1      localhost.localdomain   localhost\n::1          localhost.localdomain   localhost\n127.0.1.1    amd-arch.localdomain       amd-arch" | tee /etc/hosts

mkinitcpio -P

passwd

useradd -m bn

usermod -G wheel bn

passwd bn

cp /etc/sudoers /etc/sudoers.bak && sed -i '82c\ %wheel ALL=(ALL:ALL) ALL' /etc/sudoers

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch --removable

grub-mkconfig -o /boot/grub/grub.cfg

pacman -S networkmanager xorg-server xorg-xinit xterm xf86-video-amdgpu networkmanager xfce4 lightdm lightdm-gtk-greeter pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber xdg-user-dirs --noconfirm

pacman -S vulkan-radeon vulkan-mesa-layers libva-mesa-driver vulkan-icd-loader lib32-mesa lib32-vulkan-radeon lib32-vulkan-icd-loader lib32-vulkan-mesa-layers mesa-demos xorg-xdpyinfo amd-ucode mesa-utils --noconfirm

pacman -S xfce4-whiskermenu-plugin xfce4-pulseaudio-plugin xfce4-screenshooter ristretto mousepad galculator xfce4-screenshooter ristretto audacious --noconfirm

pacman -S ttf-ubuntu-font-family plank hardinfo audacious bluez blueman bluez-utils xarchiver file-roller tar gzip bzip2 zip unzip unrar p7zip thunar-archive-plugin galculator --noconfirm

pacman -S simplescreenrecorder ffmpeg psensor gimp gnome-disk-utility frei0r-plugins ntfs-3g exfatprogs gsmartcontrol obs-studio uget qbittorrent papirus-icon-theme telegram-desktop gamemode fatsort mpv audacious inkscape audacity kdenlive libreoffice-fresh-pt-br alsa-firmware alsa-utils a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore gstreamer gst-plugins-base gst-plugins-base-libs gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb git go fuse2 base-devel movit ttf-dejavu ttf-liberation noto-fonts noto-fonts-emoji  ttf-roboto ttf-roboto-mono ttf-opensans --noconfirm

pacman -S wine-staging wine-mono wine-gecko gamemode lib32-gamemode giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader vkd3d lib32-vkd3d lib32-gnutls winetricks --noconfirm

ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d && ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d && ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d

sed -i 12d /etc/profile.d/freetype2.sh && echo -e 'export FREETYPE_PROPERTIES="truetype:interpreter-version=40"' | tee -a /etc/profile.d/freetype2.sh

xdg-user-dirs-update

echo -e 'vm.dirty_background_ratio = 2 \nvm.dirty_ratio = 5' | tee /etc/sysctl.conf && sysctl -p

echo -e 'Section "Device"\n Identifier "AMD"\n Driver "amdgpu"\n Option "TearFree" "true"\nEndSection' | sudo tee /etc/X11/xorg.conf.d/20-amdgpu.conf

echo -e "[Unit]\n\n[Service]\nExecStart=/usr/bin/sh -c 'echo "high" > /sys/class/drm/card0/device/power_dpm_force_performance_level'\nType=idle\n\n[Install]\nWantedBy=multi-user.target" | tee /etc/systemd/system/gpu-power.service && systemctl enable gpu-power.service

truncate -s 0 /swapfile && chattr +C /swapfile && btrfs property set /swapfile compression none && fallocate -l 4096M /swapfile && chmod 600 /swapfile && mkswap /swapfile && swapon /swapfile && echo -e '/swapfile none swap defaults 0 0\n' | tee -a /etc/fstab

echo -e 'net.ipv4.ping_group_range = 1000 1000' | tee -a /etc/sysctl.d/60-mysql.conf

mv /arch /home/bn/

chown -R bn:bn /home/bn/arch/

chmod 777 /home/bn/arch

systemctl enable NetworkManager lightdm bluetooth

exit
