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
source ~/.bashrc

mkdir ~/.themes
mkdir ~/.icons
mkdir ~/.backgrounds
mv ./nixos/wallpapers/* ~/.backgrounds/
unzip -d ~/.themes/ ./nixos/themes/WhiteSur-dark.zip
unzip -d ~/.icons/ ./nixos/icons/capitaine-cursors.zip
unzip -d ~/.icons/ ./nixos/icons/BigSur.zip
unzip -d ~/.icons/ ./nixos/icons/BigSur-dark.zip

echo "plugins=(zsh-autosuggestions)" >> ~/.zshrc
echo $password | sudo -S sudo git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/icons/powerlevel10k
echo "ZSH_THEME='powerlevel10k/powerlevel10k'" >> ~/.zshrc
curl -L http://install.ohmyz.sh | sh
echo "neofetch" >> ~/.zshrc
echo "export NIXPKGS_ALLOW_UNFREE=1" >> ~/.zshrc

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
echo "alias 'dl'='wget -c --retry-connrefused --tries=0 --timeout=5'" >> ~/.zshrc
echo "alias 'ip'='curl ipinfo.io'" >> ~/.zshrc
echo "alias 'git:'='git clone https://github.com/'" >> ~/.zshrc

# grub theme
# echo $password | sudo -S sudo git clone --depth 1 https://gitlab.com/VandalByte/darkmatter-grub-theme.git
# cd darkmatter-grub-theme
# echo $password | sudo -S sudo python darkmatter-theme.py --install
# cd
# rm -fr ./darkmatter-grub-theme


############### gnome specific ###############
bash ./nixos/gnome.sh
##############################################

rm -fr ./nixos

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