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

  system.activationScripts.setupNixosLink = {
    text = ''
      # ตรวจสอบว่ามีโฟลเดอร์ /etc/nixos อยู่หรือไม่ และไม่ใช่ลิงก์
      if [ -d "/etc/nixos" ] && [ ! -L "/etc/nixos" ]; then
        echo "Moving existing /etc/nixos to /etc/nixos.bak"
        mv /etc/nixos /etc/nixos.bak
      fi

      # สร้าง Symlink ถ้ายังไม่มี
      if [ ! -L "/etc/nixos" ]; then
        echo "Creating symlink /etc/nixos -> /home/james/nixos"
        ln -s /home/james/nixos /etc/nixos
      fi
    '';
  };
}
