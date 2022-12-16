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

mkdir ~/.themes
mkdir ~/.icons
unzip -d ~/.themes ./nixos/themes/WhiteSur-dark.zip
unzip -d ~/.icons ./nixos/icons/BigSur.zip

source ~/.bashrc
# gsettings set org.gnome.desktop.interface icon-theme 'BigSur'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' #set icon theme
gnome-extensions enable material-shell@papyelgringo #enable material shell
gsettings set org.gnome.mutter center-new-windows 'true'
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'
gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-dark"
gsettings set org.gnome.desktop.wm.preferences theme "WhiteSur-dark"

echo "plugins=(zsh-autosuggestions)" >> ~/.zshrc
echo $password | sudo -S sudo git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
echo "ZSH_THEME='powerlevel10k/powerlevel10k'" >> ~/.zshrc
curl -L http://install.ohmyz.sh | sh
echo "neofetch" >> ~/.zshrc
echo "neofetch" >> ~/.bashrc
echo "export NIXPKGS_ALLOW_UNFREE=1" >> ~/.zshrc
echo "export NIXPKGS_ALLOW_UNFREE=1" >> ~/.bashrc

# place config files
echo "Adding firefox files ..."
rm -fr .mozilla
unzip -d ./ ./nixos/mozilla.zip


# aliases
echo "Adding aliases ..."
echo "alias 'nix-i'='nix-env -iA nixos'" >> ~/.zshrc
echo "alias 'nix-u'='nix-channel --update && nix-env -u'" >> ~/.zshrc
echo "alias 'nix-q'='nix-env -q'" >> ~/.zshrc
echo "alias 'nix-s'='nix search'" >> ~/.zshrc
echo "alias 'rebuild'='nixos-rebuild switch'" >> ~/.zshrc
echo "alias 'gc'='sudo -S sudo nix-collect-garbage -d && sudo nixos-rebuild switch'" >> ~/.zshrc
echo "alias 'config'='sudo nano /etc/nixos/configration.nix'" >> ~/.zshrc
echo "alias 'zshrc'='nano ~/.zshrc'" >> ~/.zshrc
echo "alias 'bashrc'='nano ~/.bashrc'" >> ~/.zshrc

echo "alias 'nix i'='nix-env -iA nixos'" >> ~/.bashrc
echo "alias 'nix u'='nix-channel --update && nix-env -u'" >> ~/.bashrc
echo "alias 'nix q'='nix-env -q'" >> ~/.bashrc
echo "alias 'nix s'='nix search'" >> ~/.bashrc
echo "alias 'nix rebuild'='nixos-rebuild switch'" >> ~/.bashrc
echo "alias 'nix gc'='sudo -S sudo nix-collect-garbage -d && sudo nixos-rebuild switch'" >> ~/.bashrc
echo "alias 'nano config'='sudo nano /etc/nixos/configration.nix'" >> ~/.bashrc
echo "alias 'nano zshrc'='nano ~/.zshrc'" >> ~/.bashrc
echo "alias 'nano bashrc'='nano ~/.bashrc'" >> ~/.bashrc

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