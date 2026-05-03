{ config, lib, pkgs, ... }:

{
  system.activationScripts.setupNixosConfig = {
    text = ''
      # --- Phase 1: Migration Setup ---
      # ตรวจสอบว่า /etc/nixos เป็นโฟลเดอร์จริง (ไม่ใช่ Link) เพื่อเตรียมย้ายมาที่ Home
      if [ -d "/etc/nixos" ] && [ ! -L "/etc/nixos" ]; then
        echo "Found real /etc/nixos. Preparing to migrate..."

        # --- Phase 2: Hardware Config Persistence ---
        # ก๊อปปี้ไฟล์ hardware จากระบบมาที่ ~/nixos (ทำเฉพาะถ้ายังไม่มีไฟล์นี้ใน ~/nixos)
        if [ -f "/etc/nixos/hardware-configuration.nix" ] && [ ! -f "/home/james/nixos/hardware-configuration.nix" ]; then
          echo "Copying hardware-configuration.nix to ~/nixos..."
          cp /etc/nixos/hardware-configuration.nix /home/james/nixos/hardware-configuration.nix
          chown james:users /home/james/nixos/hardware-configuration.nix
        fi

        # --- Phase 3: Directory Cleanup ---
        # เก็บสำรองไฟล์เดิมไว้ในรูปแบบ .bak เพื่อความปลอดภัย
        mv /etc/nixos /etc/nixos.bak
      fi

      # --- Phase 4: Symbolic Link Creation ---
      # สร้างทางลัดเชื่อมต่อถาวรระหว่างระบบกับโฟลเดอร์งานใน Home Directory
      if [ ! -L "/etc/nixos" ]; then
        echo "Creating symlink /etc/nixos -> /home/james/nixos"
        ln -s /home/james/nixos /etc/nixos
      fi
    '';
  };
}
