{ config, lib, pkgs, ... }:

{
  # 1. เปิดใช้งานระบบกราฟิกและการรองรับไลบรารี 32-bit (สำคัญมากสำหรับ Steam)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # 2. เปิดใช้งานและตั้งค่า Steam พร้อมเปิดพอร์ต Firewall ที่จำเป็น
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # สำหรับ Steam Remote Play
    dedicatedServer.openFirewall = true; # สำหรับ Local Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # สำหรับการโอนย้ายไฟล์เกมผ่านวง LAN
  };

  # 3. ติดตั้งเครื่องมือเสริมประสิทธิภาพและการจัดการเกม
  environment.systemPackages = with pkgs; [
    mangohud # เครื่องมือวัด FPS / อุณหภูมิ และตรวจเช็คการทำงานของ Hardware ขณะเล่นเกม
    protonup-qt # GUI Tool สำหรับโหลด Proton GE เวอร์ชันล่าสุดมาใช้เสริมคู่กับ Steam Play
  ];
}