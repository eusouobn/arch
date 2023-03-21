#!/usr/bin/env sh

sudo mkdir /mnt/jogos-1
sudo mkdir /mnt/jogos-2
sudo chown -R bn:bn /mnt/jogos-1
sudo chown -R bn:bn /mnt/jogos-2
sudo chmod 777 /mnt/jogos-1
sudo chmod 777 /mnt/jogos-2

sudo blkid -s UUID -o value /dev/sdb1 | while read line
do
echo -e "\nUUID=$line /mnt/jogos-1  ext4  defaults  0 0" | sudo tee -a /etc/fstab
done

sudo blkid -s UUID -o value /dev/sdb2 | while read line
do
echo -e "\nUUID=$line /mnt/jogos-2  ext4  defaults  0 0" | sudo tee -a /etc/fstab
done

