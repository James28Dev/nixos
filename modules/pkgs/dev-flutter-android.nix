{ config, lib, pkgs, ... }:

{
  # --- Android & Flutter Tools ---
  environment.systemPackages = with pkgs; [
    # --- Core Tools ---
    android-tools
    direnv
    jdk17
    nix-direnv

    # --- Editors ---
    android-studio
  ];

  # --- System Compatibility for Flutter ---
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    glibc
    stdenv.cc.cc
    xorg.libX11
    zlib
  ];

  # --- Direnv Support ---
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # --- Environment Variables ---
  environment.sessionVariables = {
    ANDROID_HOME = "/home/james/Android/Sdk";
    ANDROID_SDK_ROOT = "/home/james/Android/Sdk";
    CHROME_EXECUTABLE = "/run/current-system/sw/bin/brave"; # สำหรับ Flutter Web
  };

  # --- Android Licenses ---
  nixpkgs.config.android_sdk.accept_license = true;
}