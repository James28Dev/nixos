{ config, lib, pkgs, ... }:

{
  programs.dconf.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.xserver.enable = true;
  services.xserver.updateDbusEnvironment = true;

  # --- GNOME Bloatware Removal ---
  environment.gnome.excludePackages = with pkgs; [
    geary 
    gnome-characters 
    gnome-contacts 
    gnome-maps 
    gnome-music
    gnome-tour 
    gnome-weather 
    seahorse
    simple-scan 
  ]);

  documentation.nixos.enable = false;
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];
}