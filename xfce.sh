#!/bin/bash

systemctl --user enable pipewire-pulse.service

systemctl --user enable pipewire.service

systemctl --user --now enable wireplumber.service

#TECLADO
pc=$(cat /etc/hostname)

if [ "$pc" = "thinkpad-arch" ];then
     sudo localectl set-x11-keymap br abnt2 thinkpad

elif [ "$pc" = "amd-arch" ];then
     sudo localectl set-x11-keymap br abnt2
fi

#GRUB
pc=$(cat /etc/hostname)

if [ "$pc" = "thinkpad-arch" ];then
     sudo sed -i '2c\GRUB_TIMEOUT=1' /etc/default/grub && sudo sed -i '5c\GRUB_CMDLINE_LINUX_DEFAULT="mitigations=off psmouse.synaptics_intertouch=0"' /etc/default/grub && sudo grub-mkconfig -o /boot/grub/grub.cfg

elif [ "$pc" = "amd-arch" ];then
     sudo sed -i '2c\GRUB_TIMEOUT=1' /etc/default/grub && sudo sed -i '5c\GRUB_CMDLINE_LINUX_DEFAULT="mitigations=off"' /etc/default/grub && sudo grub-mkconfig -o /boot/grub/grub.cfg

fi

#MONTAR STEAM
pc=$(cat /etc/hostname)

if [ "$pc" = "amd-arch" ];then
     sh /home/bn/arch/mount-steam.sh
fi

#YAY
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si --noconfirm

#FIRMWARE
git clone https://aur.archlinux.org/aic94xx-firmware.git && cd aic94xx-firmware && makepkg -sri  --noconfirm
git clone https://aur.archlinux.org/wd719x-firmware.git && cd wd719x-firmware && makepkg -sri --noconfirm
git clone https://aur.archlinux.org/upd72020x-fw.git && cd upd72020x-fw && makepkg -sri --noconfirm

#DXVK
echo -e 'dxgi.maxDeviceMemory = 1024\ndxvk.numAsyncThreads = 4\ndxvk.numCompilerThreads = 4' | tee ~/.config/dxvk.conf && echo -e '\nDXVK_CONFIG_FILE=/home/bn/.config/dxvk.conf\nDXVK_ASYNC=1\nLFX=1' | sudo tee -a /etc/environment

#CONFIG
git clone http://github.com/eusouobn/xfce
cd xfce

###XFCE
tar -xvf xfce-perchannel-xml.tar.xz
rm -r /home/bn/.config/xfce4/xfconf/xfce-perchannel-xml
mv xfce-perchannel-xml /home/bn/.config/xfce4/xfconf/

###PLANK
tar -xvf plank.tar.gz
rm -r /home/bn/.config/plank
mv plank /home/bn/.config/

###AUTOSTART
tar -xvf autostart.tar.gz
rm -r /home/bn/.config/autostart
mv autostart /home/bn/.config/


#FONTCONFIG
yay -S fontconfig-ubuntu

mkdir ~/.config/fontconfig/

mv ~/arch/fonts.conf ~/.config/fontconfig/

fc-cache -f -v

#ZSH
sudo pacman -S zsh git wget && sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

sudo sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

exit
