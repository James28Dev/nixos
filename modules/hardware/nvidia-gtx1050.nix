{ config, lib, pkgs, ... }:

{
  # --- NVIDIA GTX 1050 Configuration ---
  hardware.nvidia = {
  modesetting.enable = true;
    nvidiaSettings = true;
    open = false;
    package = config.boot.kernelPackages.nvidia_x11;
  };
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
}