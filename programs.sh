#! /bin/bash

# Install Preload
sudo apt install preload -y

# Install TLP
sudo apt remove laptop-mode-tools -y
sudo add-apt-repository ppa:linrunner/tlp -y
sudo apt update
sudo apt install tlp tlp-rwd
sudo tlp start

# Install Unity-Tweak-Tool
sudo apt install unity-tweak-tool -y

# Install and setup git
sudo apt install git -y
if [ -f ./configfiles/gitconfig ]; then
	cp ./gitconfig $HOME/.gitconfig
fi

# Install and setup nano
sudo apt install nano -y
if [ -f ./configfiles/nanorc ]; then
	cp ./configfiles/nanorc $HOME/.nanorc
fi

# Install and setup vim
sudo apt install vim -y
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ets-labs/python-vimrc/master/setup.sh)"

# Install and setup tmux
sudo apt install tmux -y
if [ -f ./configfiles/tmux.conf ]; then
	cp ./configfiles/tmux.conf $HOME/.tmux.conf
	tmux source-file $HOME/.tmux.conf
fi

# Install xclip
sudo apt install xclip -y

# Generating a new ssh key
ssh-keygen -t rsa -b 4096 -C "cantuariavc@gmail.com"
# press enter three times when shell script is running
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/id_rsa
xclip -sel clip < $HOME/.ssh/id_rsa.pub

# Install google chrome
sudo apt install google-chrome -y

# Install steam
sudo apt install steam -y
