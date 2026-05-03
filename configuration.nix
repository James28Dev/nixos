{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/core.nix
    ./modules/desktop.nix
    ./modules/development.nix
    ./modules/users.nix
    ./modules/pkgs/dev-flutter-android.nix
    ./modules/pkgs/dev-node.nix
    ./modules/pkgs/gnome-stocks-watchlist-config.nix
    ./modules/pkgs/setup-nixos-config-symlink.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  
  system.stateVersion = "25.11"; 
}