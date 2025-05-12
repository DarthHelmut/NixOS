{ config, pkgs, ... }:

{
  ############################
  # Basic Server & Virtualization #
  ############################

  # Load essential kernel modules for Intel virtualization.
  boot.kernelModules = [ "kvm" "kvm_intel" ];

  # Enable OpenSSH for remote access.
  services.openssh.enable = true;

  # Firewall configuration.
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 19999 ];

  # Enable time synchronization.
  services.ntp.enable = true;

  # Enable cron for scheduled tasks.
  services.cron.enable = true;

  # Basic administrative packages.
  environment.systemPackages = with pkgs; [
    htop vim git wget curl
  ];

  # Enable sudo.
  security.sudo.enable = true;

  # Enable automatic system upgrades.
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  ############################
  # Wi-Fi Sharing & DHCP #
  ############################

  # Enable NAT for Internet sharing.
  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "enp1s0" ];

  # Configure Ethernet with a static IP.
  networking.interfaces.enp1s0 = {
    useDHCP = false;
    ipAddress = "192.168.42.1";
    prefixLength = 24;
  };
}
