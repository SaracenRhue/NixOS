# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./unstable.nix
    ];

  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nameservers = [ "9.9.9.9" ];

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME =services.gnome.core-utilities.enable = false;
= "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # Don't install gnome apps / only the desktop
  services.gnome.core-utilities.enable = false;
  # Disable tracking services
  services.gnome.tracker.enable = false;


  # Enable Tailscale
  networking.firewall.checkReversePath = "loose";
  services.tailscale.enable = true;

  # enable docker 
  virtualisation.docker.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  # Configure console keymap
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.saracen = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Saracen Rhue";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [];
  };
    programs.zsh.enable = true;
    programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" "python" "man" ];
    theme = "robbyrussell";
  };
  programs.zsh.ohMyZsh.customPkgs = [
    pkgs.zsh-autosuggestions
    pkgs.zsh-syntax-highlighting
  ];

  # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "saracen";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
#  nixpkgs.config.permittedInsecurePackages = [
#     "openssl-1.1.1v"
#    ]; 


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
    gnome-console
    streamlit
    thunderbird
    vim
    qemu
    libverto
    libvirt
    virt-manager
    distrobox
    tailscale
    grub2
    git
    curl
    wget
    htop
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    oh-my-zsh
    neofetch
    docker
    docker-compose
    ffmpeg
    #quickemu # no arm
    #brave # no arm
    #discord # no arm
    #zoom-us # no arm
    #plexamp # no arm
    plex-media-player
    python311
    github-desktop
    firefox
    gparted
    krusader
    nextcloud-client
    firefox
    vlc
    nodejs
    go
    gcc
    jre8
    tree
    #timeshift # not working
    cmatrix
    geckodriver
    terminator
    unzip
    papirus-icon-theme
    terminus_font
  ]) ++ (with pkgs.gnome; [
    #gnome-shell
    nautilus
    gnome-shell-extensions
    gnome-tweaks
  ]) ++ (with pkgs.gnomeExtensions; [
    material-shell
    user-themes
    move-clock
  ]) ++ (with pkgs.python310Packages; [
    pyyaml
    pick
    beautifulsoup4
    icecream
    selenium
    numpy
    pyautogui
    pygame
    pymysql
    torch
    flask
  ]) ++ (with pkgs.nodePackages; [
    npm
    typescript
    sass
  ]);


 virtualisation.libvirtd.enable = true;
 
 
  nix = {
    # automatically trigger garbage collection
    gc.automatic = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 30d";
    # enable experimental features (needed for flakes)
    package = pkgs.nixFlakes;
    extraOptions = ''
    experimental-features = nix-command flakes
    '';
  };
 
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  system.copySystemConfiguration = true;
  system.autoUpgrade.enable = true;  
  system.autoUpgrade.allowReboot = true; 
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-23.05";
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}