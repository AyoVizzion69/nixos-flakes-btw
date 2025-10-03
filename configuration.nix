{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];

  boot.loader = {
  efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
  };
  grub = {
     efiSupport = true;
     #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
     device = "nodev";
  };
};

  networking.hostName = "nixos-flakes-btw";
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes" ];

  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
#  services.xserver = {
#  enable = true;
#  windowManager.qtile.enable = true;
#  displayManager.sessionCommands = ''
#    xwallpaper --zoom ~/walls/wallpaper.jpg
#    xset r rate 200 35 &
#   '';
#  };


  # Hyprland

  programs.hyprland = {
    enable = true;
    withUWSM = false;
    xwayland.enable = true;
  };
     
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.ly.enable = true;
  services.desktopManager.gnome.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
 }; 
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
  programs.zsh.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vizzion = {
    isNormalUser = true;
    description = "vizzion";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "bluetooth" ];
    openssh.authorizedKeys.keys = [""];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };
  
  home-manager = {
  extraSpecialArgs = { inherit inputs; };
  users = {
  "vizzion" = import ./home.nix;
  };
};
  # Install firefox.
  programs.firefox.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  mypy
  ly
  picom
  neovim
  alacritty 
  git
  tealdeer
  xclip
  bat
  flatpak
  steam
  discord
  nil
  networkmanagerapplet
  fish
  nautilus
  dmenu
  rofi
  swww
  xwallpaper
  cmatrix
  flameshot
  htop
  tty-clock
  gnumake
  cbonsai
  wl-clipboard
  slurp
  stow
  fastfetch
  cava
  mako
  gnome-keyring
  xdg-desktop-portal-gtk
  xdg-desktop-portal-gnome
  fuzzel
  kdePackages.polkit-kde-agent-1
  xwayland-satellite
  thunderbird
  brave
  obsidian
  waybar
  unzip
  pavucontrol
  emacs
  python311Packages.pip
  arandr
  meson
  gcc
  clang
  cmake
  ninja
  kitty
  nwg-look
  hyprland
  waybar
  wofi
  sl
  ];
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  # List services that you want to enable:
  services.flatpak.enable = true;

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code

    ];
  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
   networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}

