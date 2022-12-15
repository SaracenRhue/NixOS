#!/bin/bash

## bash ./nixos/setup.sh

echo "Enter sudo password"
read password


touch ~/.bashrc
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' #set dark theme

echo $password | sudo -S sudo rm -fr /etc/nixos/configuration.nix
echo $password | sudo -S sudo cp ./nixos/configuration.nix /etc/nixos/


export NIXPKGS_ALLOW_UNFREE=1
nix-channel --update
nix-env -u

echo $password | sudo nixos-rebuild switch

source ~/.bashrc
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' #set icon theme
gnome-extensions enable material-shell@papyelgringo #enable material shell

echo "plugins=(zsh-autosuggestions)" >> ~/.zshrc
echo $password | sudo -S sudo git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
echo "ZSH_THEME='powerlevel10k/powerlevel10k'" >> ~/.zshrc
curl -L http://install.ohmyz.sh | sh
echo "neofetch" >> ~/.zshrc
echo "export NIXPKGS_ALLOW_UNFREE=1" >> ~/.zshrc
echo "zsh" >> ~/.bashrc

unzip -d ./.mozilla/ .mozilla.zip


rm -fr ./nixos

# git clone https://github.com/ChrisTitusTech/Top-5-Bootloader-Themes 
# cd Top-5-Bootloader-Themes
# sudo -S sudo bash ./install.sh
# cd ../
# echo $password | sudo -S sudo rm -fr Top-5-Bootloader-Themes


echo $password | sudo -S sudo nix-collect-garbage -d
echo $password | sudo -S sudo nixos-rebuild switch
echo "  __  __      ___ "
echo " /  )/  )/| )(_   "
echo "/(_/(__// |/ /__  "
echo "Rebooting in 5 seconds" && sleep 1
echo "Rebooting in 4 seconds" && sleep 1
echo "Rebooting in 3 seconds" && sleep 1
echo "Rebooting in 2 seconds" && sleep 1
echo "Rebooting in 1 second" && sleep 1
echo $password | sudo -S sudo reboot