{ config, pkgs, ... }:

{
  # NVIDIA configuration for Wayland sessions
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.open = false;  # Set to true if you decide to use the open-source variant
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;

  # Optional: If you need diagnostic tools, include the NVIDIA settings package.
  # Note: On a pure Wayland setup, its usage might be limited.
  environment.systemPackages = with pkgs; [ nvidia-settings ];

  # Performance tweak: Ensures DRM modesetting is enabled for NVIDIA, a requirement for GBM/EGL in Wayland.
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  # Optionally, if you require XWayland support for legacy or specific applications,
  # you can enable the X server. This will not start a full X session but provides XWayland.
  # services.xserver.enable = true;
}
