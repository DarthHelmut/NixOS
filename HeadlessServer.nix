{ config, pkgs, ... }:

{
  #################################
  # Basic Server & Virtualisation #
  #################################
  
  # Set a unique hostname.
#  networking.hostName = "nixos";
  
#  # Bootloader configuration.
#  boot.loader.grub.enable = true;
#  boot.loader.grub.version = 2;
#  boot.loader.grub.device = "/dev/sda"; # Adjust based on your boot device.
  
  # Load essential kernel modules for Intel virtualization.
  boot.kernelModules = [ "kvm" "kvm_intel" ];
  
  # Virtualisation support.
#  services.virtualisation.libvirtd.enable = true;
#  virtualisation.qemu.package = pkgs.qemu;
  
  # Enable the OpenSSH server for remote access.
  services.openssh.enable = true;
  # Optionally, disable password authentication for extra security:
  # services.openssh.passwordAuthentication = false;
  
  # Firewall configuration: allow SSH (port 22) and Netdata (port 19999).
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 19999 ];
#  networking.firewall.forwarding = true;  # Required for NAT.
  
  # Enable time synchronization.
  services.ntp.enable = true;
  
  # Enable Fail2ban to help prevent brute-force attacks.
#  security.fail2ban.enable = true;
  
  # Enable cron for scheduled tasks.
  services.cron.enable = true;
  
  # Basic administrative packages.
  environment.systemPackages = with pkgs; [
    htop        # Process viewer.
    vim         # Text editor.
    git         # Version control.
    wget        # File download utility.
    curl        # Data transfer tool.
 #   net-tools   # For basic network utilities.
  ];
  
  # Enable sudo for administrative privileges.
  security.sudo.enable = true;
  
  # Create a default user. Adjust 'myuser' and shell as desired.
 # users.users.myuser = {
 #   isNormalUser = true;
 #   extraGroups = [ "wheel" "libvirt" ];
 #   shell = pkgs.zsh;
 # };
  
  # Enable automatic system upgrades.
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  #########################################
  # Wi‑Fi Sharing: NAT, Ethernet & DHCP    #
  #########################################
  
  # Enable IP forwarding for NAT.
#  networking.ipForward = true;
  
  # Enable NAT. This lets devices on the Ethernet segment share the upstream Internet.
  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "enp1s0" ];  # Replace with your Ethernet interface.
  
  # Configure the Ethernet interface with a static IP.
  networking.interfaces.enp1s0 = {
    useDHCP = false;
    ipAddress = "192.168.42.1";  # This will be the gateway for devices.
    prefixLength = 24;
  };
  
  # Set up a DHCP/DNS server (using dnsmasq) on the Ethernet interface.
#  services.dnsmasq = {
#    enable = true;
#    interfaces = [ "enp1s0" ];  # Bind to the Ethernet port used for sharing.
#    extraConfig = ''
#      dhcp-range=192.168.42.2,192.168.42.254,24h
#    '';
#  };

  #########################################
  # Monitoring: Netdata (Dashboard Website)#
  #########################################
  
  # Enable Netdata for real-time system monitoring.
#  services.netdata = {
#    enable = true;
#    # Optional: You can customize settings as needed.
#    settings = {
      # Bind to all interfaces to allow remote access from your LAN.
#      bindAddress = "0.0.0.0";
#      port = 19999;  # Default port for Netdata's dashboard.
#    };
#  };

  # With this setup, you can view your server's CPU, memory, disk, and network usage by
  # browsing to http://<server-ip>:19999.
}
