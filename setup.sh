#! /bin/bash

# Update system
sudo apt update
sudo apt upgrade -y
sudo dpkg --configure -a
sudo apt install -f
sudo apt autoremove -y

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

# Reduces the use of SWAP
sudo bash -c "echo -e '#\n# Reduces the use of SWAP\nvm.swappiness=10' >> /etc/sysctl.conf"

# Improves cache management
sudo bash -c "echo -e '# Improves cache management\nvm.vfs_cache_pressure=50' >> /etc/sysctl.conf"

# Install Preload
sudo apt install preload -y

# Install TLP
sudo apt remove laptop-mode-tools -y
sudo add-apt-repository ppa:linrunner/tlp -y
sudo apt update
sudo apt install tlp tlp-rwd
sudo tlp start

# Withdraw guest
sudo mkdir /etc/lightdm/lightdm.conf.d
sudo bash -c "echo -e '[SeatDefaults]\nallow-guest=false' > /etc/lightdm/lightdm.conf.d/no-guest.conf"

# Install Unity-Tweak-Tool
sudo apt install unity-tweak-tool -y

# Place theme
mkdir $HOME/.themes
mv ./Y* $HOME/.themes

# Install and Customize nano
sudo apt install nano -y
echo -e 'set autoindent\nset multibuffer\nset nohelp\nset nonewlines\nset tabsize 8\nbind ^S savefile main' > $HOME/.nanorc

# Install and customize tmux
sudo apt install tmux -y
echo -e '# set window split\nbind-key v split-window -h\nbind-key b split-window\n' > $HOME/.tmux.conf
echo -e '# C-b is not acceptable -- Vim uses it\nset-option -g prefix C-a\nbind-key C-a last-window\n' >> $HOME/.tmux.conf
echo -e '# Start numbering at 1\nset -g base-index 1\n' >> $HOME/.tmux.conf
echo -e '# hjkl pane traversal\nbind h select-pane -L\nbind j select-pane -D\nbind k select-pane -U\nbind l select-pane -R\n' >> $HOME/.tmux.conf
tmux source-file $HOME/.tmux.conf
