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
  ];
}