#!/bin/bash

## bash ./nixos/setup.sh

sudo rm /etc/nixos/configuration.nix
cp ./nixos/configuration.nix /etc/nixos/

export NIXPKGS_ALLOW_UNFREE=1
nix-channel --update
nix-env -u
sudo nixos-rebuild switch

echo "plugins=(zsh-autosuggestions)" >> ~/.zshrc
sudo git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
echo "ZSH_THEME='powerlevel10k/powerlevel10k'" >> ~/.zshrc
curl -L http://install.ohmyz.sh | sh
chsh -s $(which zsh)
echo "neofetch" >> ~/.zshrc

echo "  __  __      ___ "
echo " /  )/  )/| )(_   "
echo "/(_/(__// |/ /__  "
sleep 2
#reboot
echo "Rebooting in 3 Seconds ..." && sleep 1
echo "Rebooting in 2 Seconds ..." && sleep 1
echo "Rebooting in 1 Second ..." && sleep 1
sudo reboot