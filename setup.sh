#!/bin/bash

## bash ./nixos/setup.sh

echo "Enter sudo password"
read password


git clone https://github.com/ChrisTitusTech/Top-5-Bootloader-Themes 
cd Top-5-Bootloader-Themes
echo $password | sudo -S sudo ./install.sh
cd ../
echo $password | sudo -S sudo rm -fr Top-5-Bootloader-Themes


echo $password | sudo -S sudo rm -fr /etc/nixos/configuration.nix
echo $password | sudo -S sudo cp ./nixos/configuration.nix /etc/nixos/

touch >> ~/.bashrc

export NIXPKGS_ALLOW_UNFREE=1
nix-channel --update
nix-env -u

nix-env -iA nixos.gnome.gnome-tweaks
nix-env -iA nixos.gnomeExtensions.material-shell
nix-env -iA nixos.zsh
nix-env -iA nixos.zsh-autosuggestions
nix-env -iA nixos.zsh-syntax-highlighting
nix-env -iA nixos.neofetch
# enable material shell
gnome-extensions enable material-shell@papyelgringo

echo $password | sudo -S sudo nixos-rebuild switch



source >> ~/.bashrc
echo "plugins=(zsh-autosuggestions)" >> ~/.zshrc
echo $password | sudo -S sudo git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
echo "ZSH_THEME='powerlevel10k/powerlevel10k'" >> ~/.zshrc
curl -L http://install.ohmyz.sh | sh
echo "neofetch" >> ~/.zshrc
echo "export NIXPKGS_ALLOW_UNFREE=1" >> ~/.zshrc
echo "zsh" >> ~/.bashrc

source >> ~/.bashrc
# set dark theme
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
# set icon theme
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
# enable material shell
gnome-extensions enable material-shell@papyelgringo

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