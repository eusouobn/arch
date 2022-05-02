#!/bin/bash

mount /dev/sda1 /boot/efi

localectl set-x11-keymap br abnt2 thinkpad

pacman -S nano pacman-contrib btrfs-progs sudo --noconfirm

curl -s "https://archlinux.org/mirrorlist/?country=FR&country=GB&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 -

cp /etc/pacman.conf /etc/pacman.conf.bak && sudo sed -i '37c\ParallelDownloads = 16' /etc/pacman.conf && sudo pacman -Syyyuuu

pacman -S networkmanager intel-ucode grub efibootmgr

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

hwclock --systohc

mv /etc/locale.gen /etc/locale.gen.bak

echo -e 'pt_BR.UTF-8 UTF-8' | tee /etc/locale.gen

locale-gen

echo -e 'LANG=pt_BR.UTF-8' | tee /etc/locale.conf

echo -e 'thinkpad-arch' | tee /etc/hostname

echo -e "127.0.0.1      localhost.localdomain   localhost\n::1          localhost.localdomain   localhost\n127.0.1.1    thinkpad-arch.localdomain       thinkpad-arch" | tee /etc/hosts

mkinitcpio -P

passwd

useradd -m bn

passwd bn

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch --removable

grub-mkconfig -o /boot/grub/grub.cfg

pacman -Rsnd jack2 && pacman -S networkmanager xorg-server xorg-xinit xterm xf86-video-intel xfce4 lightdm lightdm-gtk-greeter pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber mousepad galculator xfce4-screenshooter ristretto mousepad audacious xdg-user-dirs simplescreenrecorder ffmpeg psensor gimp gnome-disk-utility frei0r-plugins ntfs-3g exfatprogs gsmartcontrol obs-studio uget qbittorrent papirus-icon-theme telegram-desktop gamemode fatsort mpv audacious inkscape audacity kdenlive libreoffice-fresh-pt-br alsa-firmware alsa-utils a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore gstreamer gst-plugins-base gst-plugins-base-libs gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb git go fuse2 base-devel movit --noconfirm

xdg-user-dirs-update

systemctl enable NetworkManager lightdm

echo 'vm.dirty_background_ratio = 2 \nvm.dirty_ratio = 5' | tee /etc/sysctl.conf && sysctl -p

echo 'Section "Device"\n Identifier "Intel Graphics"\n Driver "Intel"\n Option "TearFree" "true"\nEndSection' | tee /etc/X11/xorg.conf.d/20-intel.conf

truncate -s 0 /swapfile && chattr +C /swapfile && btrfs property set /swapfile compression none && fallocate -l 4096M /swapfile && chmod 600 /swapfile && mkswap /swapfile && swapon /swapfile && echo -e '/swapfile none swap defaults 0 0\n' | tee -a /etc/fstab

echo 'net.ipv4.ping_group_range = 1000 1000' | tee -a /etc/sysctl.d/60-mysql.conf


cd /home/bn

git clone http://github.com/eusouobn/xfce
cd xfce
tar -xvf xfce-perchannel-xml.tar.xz
rm -r /home/bn/.config/xfce4/xfconf/xfce-perchannel-xml

mv xfce-perchannel-xml /home/bn/.config/xfce4/xfconf/

rm -r /home/bn/xfce

exit
