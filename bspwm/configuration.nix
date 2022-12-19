# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the BSPWM Desktop Environment.
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver.displayManager = { 
    defaultSession = "none+bspwm"; 
    setupCommands = ''
    my_laptop_external_monitor=$(${pkgs.xorg.xrandr}/bin/xrandr --query | grep 'DP-3 connected')
    if [[ $my_laptop_external_monitor = *connected* ]]; then
      ${pkgs.xorg.xrandr}/bin/xrandr --output DP-3 --primary --mode 3440x1440 --rate 100 --output eDP-1 --off
    else
      ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1200 --rate 60
    fi
    '';
    lightdm = { 
      enable = true; 
      greeter.enable = true; 
    }; 
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

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
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "saracen";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
    cargo
    ripgrep
    xorg.xbacklight
    git
    curl
    wget
    htop
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    neofetch
    #brave # no arm
    #discord # no arm
    #zoom-us # no arm
    #plexamp # no arm
    plex-media-player
    python311
    vscode
    github-desktop
    firefox
    gparted
    krusader
    nextcloud-client
    firefox
    vlc
    resilio-sync
    nodejs
    go
    gcc
    jre8
    libvirt
    tree
    timeshift
    sshpass
    cmatrix
    geckodriver
    terminator
    unzip
    papirus-icon-theme
  ]) ++ (with pkgs.python310Packages; [
    pyyaml
    pick
    beautifulsoup4
    icecream
    selenium
    pyautogui
    pygame
  ]) ++ (with pkgs.nodePackages; [
    npm
    typescript
    sass
  ]);

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-clocks
    gnome-font-viewer
    gnome-contacts
    gnome-calculator
    gnome-calendar
    gnome-maps
    gnome-music
    gnome-terminal
    gnome-weather
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    yelp
]);

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
  system.stateVersion = "22.11"; # Did you read the comment?

}