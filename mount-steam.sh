#!/usr/bin/env sh

sudo mkdir /jogos-1
sudo mkdir /jogos-2
sudo chown -R bn:bn /jogos-1
sudo chown -R bn:bn /jogos-2
sudo chmod 777 /jogos-1
sudo chmod 777 /jogos-2

sudo blkid -s UUID -o value /dev/sdb1 | while read line
do
echo -e "\nUUID=$line /jogos-1  btrfs  defaults  0 0" | sudo tee -a /etc/fstab
done

sudo blkid -s UUID -o value /dev/sdb2 | while read line
do
echo -e "\nUUID=$line /jogos-2  btrfs  defaults  0 0" | sudo tee -a /etc/fstab
done
