#!/bin/bash

## bash ./nixos/gnome/setup.sh password

password=$1 

touch ~/.bashrc
echo $password | sudo -S sudo rm -fr /etc/nixos/configuration.nix
echo $password | sudo -S sudo cp ./nixos/gnome/configuration.nix /etc/nixos/


export NIXPKGS_ALLOW_UNFREE=1
nix-channel --update
nix-env -u

echo $password | sudo nixos-rebuild switch
echo $password | sudo -S sudo cp ./nixos/.zshrc ./
source ~/.bashrc

mkdir ~/.themes
mkdir ~/.icons
mkdir ~/.backgrounds
mv ./nixos/wallpapers/* ~/.backgrounds/
unzip -d ~/.themes/ ./nixos/themes/WhiteSur-dark.zip
unzip -d ~/.icons/ ./nixos/icons/capitaine-cursors.zip
unzip -d ~/.icons/ ./nixos/icons/BigSur.zip
unzip -d ~/.icons/ ./nixos/icons/BigSur-dark.zip


echo $password | sudo -S sudo git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/icons/powerlevel10k
curl -L http://install.ohmyz.sh | sh


############### gnome specific ###############
bash ./nixos/gnome.sh
##############################################

rm -fr ./nixos

echo $password | sudo -S sudo nix-collect-garbage -d
echo $password | sudo -S sudo nixos-rebuild switch --upgrade
echo "  __  __      ___ "
echo " /  )/  )/| )(_   "
echo "/(_/(__// |/ /__  "
echo "                   "
echo "Start tailscale using sudo tailscale up" && sleep 1
echo "Rebooting in 5 seconds" && sleep 1
echo "Rebooting in 4 seconds" && sleep 1
echo "Rebooting in 3 seconds" && sleep 1
echo "Rebooting in 2 seconds" && sleep 1
echo "Rebooting in 1 second" && sleep 1
echo $password | sudo -S sudo reboot