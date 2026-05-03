{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Core Tools ---
    git
    tree
    unzip
    wget

    # --- Browsers ---
    brave

    # --- Editors ---
    nano
    vscode

    # --- System & UI ---
    adwaita-icon-theme
    hicolor-icon-theme
    mesa-demos

  programs.direnv.enable = true; 
  programs.direnv.nix-direnv.enable = true;
  programs.nix-ld.enable = true; 
  programs.nix-ld.libraries = with pkgs; [
    glibc 
    stdenv.cc.cc 
    xorg.libX11
    zlib 
    gnomeExtensions.stocks-extension
  ];
}