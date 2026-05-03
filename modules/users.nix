{ config, lib, pkgs, ... }:

{
  # --- Primary User Account: James ---
  users.users.james = {
    extraGroups = [
      "adbusers"
      "kvm"
      "libvirtd"
      "networkmanager"
      "wheel"
    ];
    isNormalUser = true;
    packages = with pkgs; [ 
      tree 
    ];
  };

  # --- Secondary User Account: Guest ---
  users.users.guest = { 
    description = "Guest User";
    extraGroups = [
      "networkmanager"
    ];
    initialPassword = ""; 
    isNormalUser = true;
  };
}