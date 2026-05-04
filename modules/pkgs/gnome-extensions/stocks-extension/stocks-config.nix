# --- NixOS Module: Stocks Extension Auto-Loader ---
# Description: Automates the loading of GNOME Stocks Extension settings

{ config, lib, pkgs, ... }:

{
  # --- Place the config file on the system ---
  environment.etc."stocks.dconf".source = ./stocks.dconf;

  # --- Script load stocks ---
  # Create a script to load stock values into the dconf user account
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "load-stocks-config" ''
      # รอให้ D-Bus พร้อม (เผื่อไว้ 2 วินาที)
      sleep 2
      if [ -f /etc/stocks.dconf ]; then
        ${pkgs.dconf}/bin/dconf load /org/gnome/shell/extensions/stocks/ < /etc/stocks.dconf
      fi
    '')
  ];

  # --- Configure autostart james log in ---
  # Configure Autostart to run the script every time James logs in.
  environment.etc."xdg/autostart/load-stocks.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Load Stocks Config
    Exec=load-stocks-config
    NoDisplay=true
    X-GNOME-Autostart-enabled=true
  '';
}