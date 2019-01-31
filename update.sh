#! /bin/sh

# Update system
sudo apt update && \
sudo apt upgrade -y && \
sudo dpkg --configure -a && \
sudo apt install -f && \
sudo apt autoremove -y
