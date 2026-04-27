{ config, lib, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.systemd-boot.enable = true;

  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 14d";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "th_TH.UTF-8/UTF-8" ];

  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Bangkok";

  system.activationScripts.setupNixosConfig = {
    text = ''
      # 1. เตรียมพื้นที่: ถ้ามีไฟล์จริงอยู่ที่ /etc/nixos ให้จัดการก่อน
      if [ -d "/etc/nixos" ] && [ ! -L "/etc/nixos" ]; then
        echo "Found real /etc/nixos. Preparing to migrate..."

        # 2. ก๊อปปี้ไฟล์ hardware จากระบบมาที่ ~/nixos (ทำเฉพาะถ้ายังไม่มีไฟล์นี้ใน ~/nixos)
        if [ -f "/etc/nixos/hardware-configuration.nix" ] && [ ! -f "/home/james/nixos/hardware-configuration.nix" ]; then
          echo "Copying hardware-configuration.nix to ~/nixos..."
          cp /etc/nixos/hardware-configuration.nix /home/james/nixos/hardware-configuration.nix
          chown james:users /home/james/nixos/hardware-configuration.nix
        fi

        # 3. เปลี่ยนชื่อโฟลเดอร์เดิมทิ้งเพื่อเปิดทางให้การสร้าง Link
        mv /etc/nixos /etc/nixos.bak
      fi

      # 4. สร้าง Symlink: เชื่อมต่อโลกของระบบเข้ากับโฟลเดอร์งานของ James
      if [ ! -L "/etc/nixos" ]; then
        echo "Creating symlink /etc/nixos -> /home/james/nixos"
        ln -s /home/james/nixos /etc/nixos
      fi
    '';
  };
}
