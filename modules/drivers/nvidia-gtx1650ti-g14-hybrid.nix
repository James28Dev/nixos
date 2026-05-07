{ config, lib, pkgs, ... }:

{
  # --- CRITICAL: PCI Bus IDs ---
  # Run: nix shell nixpkgs#pciutils -c sh -c "lspci -nn | grep -E 'VGA|3D'" to find your IDs, Example of entering actual values: "PCI:4:0:0"
  hardware.nvidia.prime.amdgpuBusId = "example PCI:4:0:0";
  hardware.nvidia.prime.nvidiaBusId = "example PCI:1:0:0";

  # --- NVIDIA GTX 1650 Ti (G14 Hybrid) Configuration ---
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true; # Required for Steam/32-bit apps
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = false;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.powerManagement.enable = true; # Improved power management for 1650 Ti laptops
  hardware.nvidia.powerManagement.finegrained = true;
  hardware.nvidia.prime.offload.enable = true;
  hardware.nvidia.prime.offload.enableOffloadCmd = true;

  # --- Boot & Stability Optimization ---
  # boot.initrd.kernelModules = [ "nvidia" ];
  boot.kernelParams = [ "nvidia-drm.modeset=1" "module_blacklist=nouveau" ];
  services.xserver.videoDrivers = [ "nvidia" ];

  # --- Display Manager & X11 Config ---
  services.displayManager.gdm.wayland = false;
  # services.displayManager.defaultSession = "gnome";

  # --- Custom Scripts & Packages ---
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nvidia-offload" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_SETTING=1
      export __VK_LAYER_NV_optimus=NVIDIA_only
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      exec "$@"
    '')
  ];
}