#!/bin/bash

# place config files
echo "Adding firefox files ..."
rm -fr .mozilla
unzip -d ./ ./nixos/gnome/mozilla.zip

# settings
# gsettings set org.gnome.desktop.interface icon-theme 'BigSur-dark'
# gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-dark'
# gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' #set dark theme
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' #set icon theme
gsettings set org.gnome.mutter center-new-windows 'true'
gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
gsettings set org.gnome.desktop.interface cursor-theme 'capitaine-cursors'
# extensions
gnome-extensions enable material-shell@papyelgringo #enable material shell
gnome-extensions enable user-theme@gnome-shell-extensions.gcmpax.github.com #enable user theme
gnome-extensions enable Move_Clock@rmy.pobox.com #enable move clock
gnome-extensions enable custom-accent-color@demiskp #enable custom accent color