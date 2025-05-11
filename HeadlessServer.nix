{ config, pkgs, ... }:

{
  ######################
  # Basic Server Setup #
  ######################
  
  # Set a unique hostname.
  networking.hostName = "my-server";
  
  # Bootloader configuration.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # Adjust based on your boot device.
  
  # Virtualization support.
  boot.kernelModules = [ "kvm" "kvm_intel" ];
  services.virtualisation.libvirtd.enable = true;
  virtualisation.qemu.package = pkgs.qemu;
  
  # SSH server for secure remote access.
  services.openssh.enable = true;
  # For tighter security, consider disabling password authentication:
  # services.openssh.passwordAuthentication = false;

  # Enable the firewall and allow SSH (port 22).
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.forwarding = true;  # Allow forwarding for NAT.
  
  # Enable NTP for accurate time synchronization.
  services.ntp.enable = true;
  
  # Security: Fail2ban to protect against brute force attacks.
  security.fail2ban.enable = true;
  
  # Enable cron for scheduled tasks.
  services.cron.enable = true;
  
  # Basic administrative tools.
  environment.systemPackages = with pkgs; [
    htop      # Process viewer.
    vim       # Text editor.
    git       # Version control.
    wget      # File download utility.
    curl      # Command line tool for transferring data.
    net-tools # Basic network utilities.
  ];
  
  # Enable sudo for administrative privileges.
  security.sudo.enable = true;
  
  # Create a default user; adjust username and shell as desired.
  users.users.myuser = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirt" ];  # 'wheel' for sudo, 'libvirt' for VM management.
    shell = pkgs.zsh;
  };
  
  # Automatic system updates.
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  #########################################
  # Wi‑Fi Sharing: NAT & DHCP on Ethernet #
  #########################################
  
  # Enable IP forwarding. This is needed for NAT and is typically enabled
  # when networking.nat.enable is true, but we state it explicitly.
  networking.ipForward = true;
  
  # Enable NAT so that devices on the Ethernet network can reach the upstream Internet.
  # Here we assume that your upstream connection (Wi‑Fi) is already working.
  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "enp1s0" ];  # Replace with your Ethernet interface.
  
  # Configure the Ethernet interface with a static IP.
  networking.interfaces.enp1s0 = {
    useDHCP = false;
    ipAddress = "192.168.42.1";  # Gateway for devices connecting via Ethernet.
    prefixLength = 24;
  };
  
  # Set up a DHCP and DNS server (via dnsmasq) on the Ethernet interface so that devices
  # (like your Raspberry Pi 4) receive an IP address automatically.
  services.dnsmasq = {
    enable = true;
    interfaces = [ "enp1s0" ];  # Bind dnsmasq to the Ethernet interface.
    extraConfig = ''
      dhcp-range=192.168.42.2,192.168.42.254,24h
    '';
  };

  #######################
  # End of Server Config
  #######################
}
