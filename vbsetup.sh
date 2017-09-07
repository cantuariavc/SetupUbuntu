#! /bin/sh

# Update system
sudo apt update
sudo apt upgrade -y
sudo dpkg --configure -a
sudo apt install -f
sudo apt autoremove -y

# Force Color Prompt
sed 's/#force_color_prompt=yes/force_color_prompt=yes/g' $HOME/.bashrc > $HOME/.bashrc1 && mv $HOME/.bashrc1 $HOME/.bashrc

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

# Reduces the use of SWAP
sudo sh -c "echo -e '#\n# Reduces the use of SWAP\nvm.swappiness=10' >> /etc/sysctl.conf"

# Improves cache management
sudo sh -c "echo -e '# Improves cache management\nvm.vfs_cache_pressure=50' >> /etc/sysctl.conf"

# Withdraw guest
if [ -d /etc/lightdm/lightdm.conf.d ]; then
	sudo sh -c "echo -e '[SeatDefaults]\nallow-guest=false' > /etc/lightdm/lightdm.conf.d/no-guest.conf"
else
	mkdir /etc/lightdm/lightdm.conf.d
	sudo sh -c "echo -e '[SeatDefaults]\nallow-guest=false' > /etc/lightdm/lightdm.conf.d/no-guest.conf"
fi
