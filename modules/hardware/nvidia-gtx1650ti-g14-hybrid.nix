{ config, lib, pkgs, ... }:

{
  # --- NVIDIA GTX 1650 Ti (G14 Hybrid) Configuration ---
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    # Improved power management for 1650 Ti laptops
    powerManagement.enable = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # --- IMPORTANT: Match Bus IDs with your hardware ---
      # Run: nix-shell -p pciutils --run "lspci -nn | grep -E 'VGA|3D'" to find your IDs
      nvidiaBusId = "example PCI:1:0:0";
      amdgpuBusId = "example PCI:4:0:0";
    };
  };
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
}