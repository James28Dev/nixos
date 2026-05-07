{ config, pkgs, lib, ... }: {

  # --- Kernel & Driver Level ---
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  # --- Hardware Driver Config ---
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.open = false; # GTX 1050 must use proprietary
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  hardware.nvidia.powerManagement.enable = true;
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true; # Required for Steam/32-bit apps

  # --- Display Manager Fixes (Specific to this GPU) ---
  # SDDM/X11 is being enforced because GDM/Wayland has issues with the 580 driver.
  services.displayManager.gdm.enable = lib.mkForce false;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = false;

  # Fix core-dump issues by delaying the restart.
  systemd.services.display-manager.serviceConfig.RestartSec = lib.mkForce "5s";

  services.xserver.videoDrivers = [ "nvidia" ];
}