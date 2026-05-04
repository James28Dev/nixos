{ config, lib, pkgs, ... }:

{
  # --- Bootloader & Kernel ---
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.systemd-boot.enable = true;

  # --- Nix Maintenance ---
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 14d";
  nix.settings.auto-optimise-store = true;

  # --- Localization & Internationalization ---
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      libthai
    ];
  };
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "th_TH.UTF-8/UTF-8" ];
  time.timeZone = "Asia/Bangkok";

  # --- Keyboard Layout ---
  services.xserver.xkb = {
    layout = "us,th";
    options = "grp:win_space_toggle";
  };

  # --- System-wide Fonts ---
  fonts.packages = with pkgs; [
    liberation_ttf
    noto-fonts
    nerd-fonts.fira-mono
  ];

  # --- Networking ---
  networking.networkmanager.enable = true;
}
