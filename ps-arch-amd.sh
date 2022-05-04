#!/bin/bash

pacman -S base-devel nano pacman-contrib btrfs-progs sudo networkmanager amd-ucode grub efibootmgr --noconfirm

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak && reflector --country Brazil --sort rate --save /etc/pacman.d/mirrorlist

cp /etc/pacman.conf /etc/pacman.conf.bak && sed -i '37c\ParallelDownloads = 16' /etc/pacman.conf && pacman -Syyyuuu

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

passwd bn

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch --removable

grub-mkconfig -o /boot/grub/grub.cfg

pacman -S networkmanager xorg-server xorg-xinit xterm xf86-video-amdgpu xfce4 lightdm lightdm-gtk-greeter pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber mousepad galculator xfce4-screenshooter ristretto mousepad audacious xdg-user-dirs simplescreenrecorder ffmpeg psensor gimp gnome-disk-utility frei0r-plugins ntfs-3g exfatprogs gsmartcontrol obs-studio uget qbittorrent papirus-icon-theme telegram-desktop gamemode fatsort mpv audacious inkscape audacity kdenlive libreoffice-fresh-pt-br alsa-firmware alsa-utils a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore gstreamer gst-plugins-base gst-plugins-base-libs gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb git go fuse2 base-devel movit --noconfirm

xdg-user-dirs-update

systemctl enable NetworkManager lightdm

echo -e 'vm.dirty_background_ratio = 2 \nvm.dirty_ratio = 5' | tee /etc/sysctl.conf && sysctl -p

echo -e 'Section "Device"\n Identifier "AMD"\n Driver "amdgpu"\n Option "TearFree" "true"\nEndSection' | sudo tee /etc/X11/xorg.conf.d/20-amdgpu.conf

echo -e "[Unit]\n\n[Service]\nExecStart=/usr/bin/sh -c 'echo "high" > /sys/class/drm/card0/device/power_dpm_force_performance_level'\nType=idle\n\n[Install]\nWantedBy=multi-user.target" | tee /etc/systemd/system/gpu-power.service && systemctl enable gpu-power.service

truncate -s 0 /swapfile && chattr +C /swapfile && btrfs property set /swapfile compression none && fallocate -l 4096M /swapfile && chmod 600 /swapfile && mkswap /swapfile && swapon /swapfile && echo -e '/swapfile none swap defaults 0 0\n' | tee -a /etc/fstab

echo -e 'net.ipv4.ping_group_range = 1000 1000' | tee -a /etc/sysctl.d/60-mysql.conf

