{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Core Tools ---
    direnv 
    git 
    nix-direnv 
    tree
    unzip 
    wget 
    # --- Editors & Browsers ---
    android-studio
    brave 
    nano 
    neovim 
    vscode 
    # --- System & UI ---
    adwaita-icon-theme 
    hicolor-icon-theme 
    mesa-demos
    # --- Development ---
    android-tools 
    jdk17
    nodejs_20 
  ];

  programs.direnv.enable = true; 
  programs.direnv.nix-direnv.enable = true;
  programs.nix-ld.enable = true; 
  programs.nix-ld.libraries = with pkgs; [
    glibc 
    stdenv.cc.cc 
    xorg.libX11
    zlib 
  ];

  environment.sessionVariables = {
    ANDROID_HOME = "/home/james/Android/Sdk";
    ANDROID_SDK_ROOT = "/home/james/Android/Sdk";
    CHROME_EXECUTABLE = "/run/current-system/sw/bin/brave";
    PATH = [ "$HOME/.npm-global/bin" ];
  };

  nixpkgs.config.android_sdk.accept_license = true;
}