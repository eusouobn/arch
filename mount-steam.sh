#!/usr/bin/env sh

sudo mkdir /steam
sudo chown -R bn:bn /steam
sudo chmod 777 /steam   
sudo blkid -s UUID -o value /dev/sdb1 | while read line
do
echo -e "\nUUID=$line /steam  btrfs  defaults  0 0" | sudo tee -a /etc/fstab
done
