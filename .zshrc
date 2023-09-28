export NIXPKGS_ALLOW_UNFREE=1
alias 'nix-i'='nix-env -iA nixos'
alias 'nix-u'='nix-channel --update && nix-env -u'
alias 'nix-q'='nix-env -q'
alias 'nix-s'='nix search'
alias 'rebuild'='sudo nixos-rebuild switch'
alias 'rebuild-u'='sudo nixos-rebuild switch --upgrade' 
alias 'gc'='sudo -S sudo nix-collect-garbage -d && sudo nixos-rebuild switch'
alias 'dl'='wget -c --retry-connrefused --tries=0 --timeout=5'
alias 'ipinfo'='curl ipinfo.io'
alias 'git:'='git clone https://github.com/'
neofetch
