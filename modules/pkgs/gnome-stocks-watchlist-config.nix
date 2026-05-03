{ config, lib, pkgs, ... }:

{
  # --- GNOME Shell & Extensions Configuration ---
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    # --- Stocks Extension Settings ---
    [org.gnome.shell.extensions.stocks]
    panel-slot='right'
    show-on-fixed-width=true
    symbols=['NVDA', 'GOOGL', 'VOO', 'QQQM', 'JEPQ']
    update-interval=60

    # --- Enabled Shell Extensions ---
    [org.gnome.shell]
    enabled-extensions=['stocks@as-com.github.io']
  '';
}