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
    ptyxis
    vscode

    # --- System & UI ---
    adwaita-icon-theme
    mesa-demos
  ];
}