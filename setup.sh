#!/bin/bash

## bash ./nixos/setup.sh

echo "Enter sudo password"
read password



# git clone https://github.com/ChrisTitusTech/Top-5-Bootloader-Themes 
# cd Top-5-Bootloader-Themes
# echo $password | sudo -S sudo ./install.sh
# cd ../
# echo $password | sudo -S sudo rm -fr Top-5-Bootloader-Themes

touch ~/.bashrc
echo $password | sudo -S sudo rm -fr /etc/nixos/configuration.nix
echo $password | sudo -S sudo cp ./nixos/configuration.nix /etc/nixos/


export NIXPKGS_ALLOW_UNFREE=1
nix-channel --update
nix-env -u

nix-env -e nixos.gnomecheese # webcam tool
nix-env -e nixos.gnome-calculator
nix-env -e nixos.gnome-calendar
nix-env -e nixos.gnome-maps
nix-env -e nixos.gnome-music
nix-env -e nixos.gnome-terminal
nix-env -e nixos.gnome-weather
nix-env -e nixos.gedit # text editor
nix-env -e nixos.epiphany # web browser
nix-env -e nixos.geary # email reader
nix-env -e nixos.evince # document viewer
nix-env -e nixos.gnome-characters
nix-env -e nixos.totem # video player
nix-env -e nixos.tali # poker game
nix-env -e nixos.iagno # go game
nix-env -e nixos.hitori # sudoku game
nix-env -e nixos.atomix # puzzle game
nix-env -e nixos.yelp
nix-env -e nixos.gnome.gnome-photos
nix-env -e nixos.gnome.gnome-tour

nix-env -iA nixos.gnome.gnome-tweaks
nix-env -iA nixos.gnomeExtensions.material-shell
nix-env -iA nixos.papirus-icon-theme
nix-env -iA nixos.zsh
nix-env -iA nixos.zsh-autosuggestions
nix-env -iA nixos.zsh-syntax-highlighting
nix-env -iA nixos.neofetch


source ~/.bashrc
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' #set dark theme
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' #set icon theme
gnome-extensions enable material-shell@papyelgringo #enable material shell


echo "plugins=(zsh-autosuggestions)" >> ~/.zshrc
echo $password | sudo -S sudo git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
echo "ZSH_THEME='powerlevel10k/powerlevel10k'" >> ~/.zshrc
curl -L http://install.ohmyz.sh | sh
echo "neofetch" >> ~/.zshrc
echo "export NIXPKGS_ALLOW_UNFREE=1" >> ~/.zshrc
source ~/.bashrc



echo $password | sudo -S sudo nixos-rebuild switch
echo "zsh" >> ~/.bashrc
rm -fr ./nixos
echo "  __  __      ___ "
echo " /  )/  )/| )(_   "
echo "/(_/(__// |/ /__  "
sleep 2
#reboot
echo "Rebooting in 3 Seconds ..." && sleep 1
echo "Rebooting in 2 Seconds ..." && sleep 1
echo "Rebooting in 1 Second ..." && sleep 1
echo $password | sudo -S sudo reboot