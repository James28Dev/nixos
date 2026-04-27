{ config, lib, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.systemd-boot.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "th_TH.UTF-8/UTF-8" ];

  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Bangkok";
}
