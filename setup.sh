#!/bin/bash

## bash ./nixos/gnome/setup.sh password

password=$1 

touch ~/.bashrc
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' #set dark theme

echo $password | sudo -S sudo rm -fr /etc/nixos/configuration.nix
echo $password | sudo -S sudo cp ./nixos/gnome/configuration.nix /etc/nixos/


export NIXPKGS_ALLOW_UNFREE=1
nix-channel --update
nix-env -u

echo $password | sudo nixos-rebuild switch
source ~/.bashrc

mkdir ~/.themes
mkdir ~/.icons
mkdir ~/.backgrounds
mv ./nixos/wallpapers/* ~/.backgrounds/
unzip -d ~/.themes/ ./nixos/themes/WhiteSur-dark.zip
unzip -d ~/.icons/ ./nixos/icons/capitaine-cursors.zip
unzip -d ~/.icons/ ./nixos/icons/BigSur.zip
unzip -d ~/.icons/ ./nixos/icons/BigSur-dark.zip

# settings
# gsettings set org.gnome.desktop.interface icon-theme 'BigSur-dark'
# gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-dark'
# gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' #set icon theme
gsettings set org.gnome.mutter center-new-windows 'true'
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
gsettings set org.gnome.desktop.interface cursor-theme 'capitaine-cursors'
# extensions
gnome-extensions enable material-shell@papyelgringo #enable material shell
gnome-extensions enable user-theme@gnome-shell-extensions.gcmpax.github.com #enable user theme
gnome-extensions enable Move_Clock@rmy.pobox.com #enable move clock


echo "plugins=(zsh-autosuggestions)" >> ~/.zshrc
echo $password | sudo -S sudo git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/icons/powerlevel10k
echo "ZSH_THEME='powerlevel10k/powerlevel10k'" >> ~/.zshrc
curl -L http://install.ohmyz.sh | sh

echo "neofetch" >> ~/.zshrc
echo "export NIXPKGS_ALLOW_UNFREE=1" >> ~/.zshrc
echo "neofetch" >> ~/.bashrc
echo "export NIXPKGS_ALLOW_UNFREE=1" >> ~/.bashrc

# place config files
echo "Adding firefox files ..."
rm -fr .mozilla
unzip -d ./ ./nixos/configs/mozilla.zip

# grub theme
echo $password | sudo -S sudo git clone --depth 1 https://gitlab.com/VandalByte/darkmatter-grub-theme.git && cd darkmatter-grub-theme
echo $password | sudo -S sudo python darkmatter-theme.py --install
cd ../

# aliases
# zsh
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
# bash
echo "alias 'nix-i'='nix-env -iA nixos'" >> ~/.bashrc
echo "alias 'nix-u'='nix-channel --update && nix-env -u'" >> ~/.bashrc
echo "alias 'nix-q'='nix-env -q'" >> ~/.bashrc
echo "alias 'nix-s'='nix search'" >> ~/.bashrc
echo "alias 'rebuild'='nixos-rebuild switch'" >> ~/.bashrc
echo "alias 'gc'='sudo -S sudo nix-collect-garbage -d && sudo nixos-rebuild switch'" >> ~/.bashrc
echo "alias 'config'='sudo nano /etc/nixos/configration.nix'" >> ~/.bashrc
echo "alias 'zshrc'='nano ~/.zshrc'" >> ~/.bashrc
echo "alias 'bashrc'='nano ~/.bashrc'" >> ~/.bashrc

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