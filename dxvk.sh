#!/usr/bin/env sh

vram=$(sudo glxinfo | grep "Video memory" | cut -d ":" -f2 | cut -d "M" -f1)

cat /proc/cpuinfo | grep processor | wc -l | while read line
do
echo -e "dxgi.maxDeviceMemory =$vram\ndxvk.enableAsync = True\ndxvk.numAsyncThreads = $line\ndxvk.numCompilerThreads = $line\n" | tee -a /home/$USER/.config/dxvk.conf
done



file=/etc/environment
if [  $(grep -c DXVK_ASYNC=1 /etc/environment) != 0 ]; then
     echo "$(tput bel)$(tput bold)$(tput setaf 2)"Ok""
     else
cat <<EOF | sudo tee -a /etc/environment
DXVK_ASYNC=1
EOF
fi

file=/etc/environment
if [  $(grep -c LFX=1 /etc/environment) != 0 ]; then
     echo "$(tput bel)$(tput bold)$(tput setaf 2)"Ok""
     else
cat <<EOF | sudo tee -a /etc/environment
LFX=1
EOF
fi

file=/etc/environment
if [  $(grep -c "DXVK_CONFIG_FILE=/home/$USER/.config/dxvk.conf" /etc/environment) != 0 ]; then
     echo "$(tput bel)$(tput bold)$(tput setaf 2)"Ok""
     else
cat <<EOF | sudo tee -a /etc/environment
DXVK_CONFIG_FILE=/home/$USER/.config/dxvk.conf
EOF
fi
echo "$(tput bel)$(tput bold)$(tput setaf 2)"Feito" $(tput setaf 7)$(tput setab 4)Ok...$(tput sgr0)"