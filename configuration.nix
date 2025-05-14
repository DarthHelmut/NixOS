{ config, pkgs, ... }:

{
  # Import the hardware configuration and your Hyprland module.
  imports = [
    ./hardware-configuration.nix
    ./hyprland.nix
    ./nvidiagpu.nix
    ./HeadlessServer.nix
    ./kde.nix
  ];



nix.settings.experimental-features = [ "nix-command" "flakes" ];



  ####################################
  # Bootloader & UEFI Configuration  #
  ####################################
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ###############################
  # System & Network Settings   #
  ###############################
  networking.hostName = "nixos";    # Define your hostname.
  networking.networkmanager.enable = true;

  # (Hyprland is now configured in hyprland.nix)

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  ################################
  # Internationalisation & Locale #
  ################################
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT    = "en_US.UTF-8";
    LC_MONETARY       = "en_US.UTF-8";
    LC_NAME           = "en_US.UTF-8";
    LC_NUMERIC        = "en_US.UTF-8";
    LC_PAPER          = "en_US.UTF-8";
    LC_TELEPHONE      = "en_US.UTF-8";
    LC_TIME           = "en_US.UTF-8";
  };

  #####################################
  # X Server & Display Manager Config #
  #####################################
  services.xserver = {
    enable       = true;
    layout       = "us";
    videoDrivers = [ "modesetting" ];
    
    displayManager.gdm = {
      enable  = true;
      wayland = true;
    };
    # Remove or omit desktopManager.default for a Wayland-only session.
  };

  #########################
  # User Configuration    #
  #########################
  users.users.c0re = {
    isNormalUser = true;
    description  = "c0re";
    extraGroups  = [ "networkmanager" "wheel" ];
    packages     = with pkgs; [ ];
  };

  ################################
  # System Packages & Preferences#
  ################################
  # Allow installation of unfree packages.
  nixpkgs.config.allowUnfree = true;

  # List packages installed in the system profile.
  environment.systemPackages = with pkgs; [
    vim          # Text editor.
    wget         # File downloader.
    git          # Version control.
    fastfetch    # System info fetch tool.
    kitty        # Terminal emulator.
    waybar       # Status bar.
    wofi         # Application launcher.
    firefox      # Web browser.
    hyprpaper    # Wallpaper setter for Hyprland.
    mako         # Notification daemon.
  ];

  ##########################
  # Additional Services    #
  ##########################
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  ###################################
  # System State Version Management #
  ###################################
  system.stateVersion = "24.11";
}
