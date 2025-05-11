{ config, pkgs, ... }:

{
  # Enable the NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];

  # Ensure proprietary NVIDIA settings are available
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.open = false; # Set to true if using the open-source variant
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;

  # Optional: Enable the NVIDIA settings GUI
  environment.systemPackages = with pkgs; [ nvidia-settings ];

  # Performance tweaks
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
}

