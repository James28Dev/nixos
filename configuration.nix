{ config, lib, pkgs, ... }:

{
  # --- System Module Imports ---
  imports = [
    ./hardware-configuration.nix
    ./modules/core.nix
    ./modules/desktop.nix
    ./modules/development.nix
    ./modules/users.nix
    # --- Custom Package Configurations ---
    ./modules/pkgs/developments/dev-flutter-android.nix
    ./modules/pkgs/developments/dev-node.nix
    ./modules/pkgs/setup-nixos-config-symlink.nix
    ./modules/pkgs/shell-config.nix
    ./modules/pkgs/gnome-extensions/stocks-extension/stocks-config.nix
  ];

  # --- Nix Package Manager Settings ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # --- System Version Compatibility ---
  system.stateVersion = "25.11"; 
}