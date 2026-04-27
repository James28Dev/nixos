{ config, lib, pkgs, ... }:

{
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

  users.users.guest = { 
    description = "Guest User";
    initialPassword = ""; 
    isNormalUser = true;
  };
}