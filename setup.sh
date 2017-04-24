#! /bin/bash

# Update system
sudo apt update
sudo apt upgrade -y
sudo dpkg --configure -a
sudo apt install -f
sudo apt autoremove -y

# Force Color Prompt
sed 's/#force_color_prompt=yes/force_color_prompt=yes/g' $HOME/.bashrc > $HOME/.bashrc1 && mv $HOME/.bashrc1 $HOME/.bashrc

# Decrease grud's time
sudo bash -c "sed 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=1/g' /etc/default/grub > /etc/default/grub1 && mv /etc/default/grub1 /etc/default/grub"
sudo update-grub

# Turns off unity visual effects
if [ ! -f $HOME/.xprofile ]; then
    echo 'export UNITY_LOW_GFX_MODE=1' > $HOME/.xprofile
else
    grep 'export UNITY_LOW_GFX_MODE=0' $HOME/.xprofile > ulgfx
    if [ -s ulgfx ]; then
        sed s/export\ UNITY_LOW_GFX_MODE=0/export\ UNITY_LOW_GFX_MODE=1/g $HOME/.xprofile > $HOME/.xprofile1 && mv $HOME/.xprofile1 $HOME/.xprofile
    fi
    rm -rf ulgfx
fi

# Set Desktop Wallpaper
if [ -f ./system/wallpaper/* ]; then
	gsettings set org.gnome.desktop.background picture-uri file:///./system/wallpaper/*
fi

# Reduces the use of SWAP
sudo bash -c "echo -e '#\n# Reduces the use of SWAP\nvm.swappiness=10' >> /etc/sysctl.conf"

# Improves cache management
sudo bash -c "echo -e '# Improves cache management\nvm.vfs_cache_pressure=50' >> /etc/sysctl.conf"

# Withdraw guest
if [ -d /etc/lightdm/lightdm.conf.d ]; then
	sudo bash -c "echo -e '[SeatDefaults]\nallow-guest=false' > /etc/lightdm/lightdm.conf.d/no-guest.conf"
else
	mkdir /etc/lightdm/lightdm.conf.d
	sudo bash -c "echo -e '[SeatDefaults]\nallow-guest=false' > /etc/lightdm/lightdm.conf.d/no-guest.conf"
fi

# Install Programs
./programs.sh
