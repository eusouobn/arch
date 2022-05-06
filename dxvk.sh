#!/usr/bin/env sh

vram=$(sudo glxinfo | grep "Video memory" | cut -d ":" -f2 | cut -d "M" -f1)
DXVK=/home/$USER/.config/dxvk.conf
ENV=/etc/environment

if [ -e "$DXVK" ] ; then
echo -e "\n\nArquivo DXVK.conf existe"
mv /home/$USER/.config/dxvk.conf /home/bn/.config/dxvk.conf.bak
echo -e "Movido para ~/.config/dxvk.conf.bak\n\n"
fi

cat /proc/cpuinfo | grep processor | wc -l | while read line
do
echo -e "dxgi.maxDeviceMemory =$vram\ndxvk.enableAsync = True\ndxvk.numAsyncThreads = $line\ndxvk.numCompilerThreads = $line\n" | tee -a /home/$USER/.config/dxvk.conf

if [ -e "$ENV" ] ; then
echo -e "\n\nArquivo Environment existe"
sudo mv /etc/environment /etc/environment.bak
echo -e "Movido para /etc/environment.bak\n\n"

file=/etc/environment
cat <<EOF | sudo tee -a /etc/environment
DXVK_CONFIG_FILE=/home/$USER/.config/dxvk.conf
DXVK_ASYNC=1
LFX=1
EOF
fi
done