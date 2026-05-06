{ config, lib, pkgs, ... }:

{
  # --- system packages & custom loader script ---
  environment.systemPackages = with pkgs; [
    gnome-extension-manager
    gnome-tweaks
    # --- Gnome Extensions ---
    gnomeExtensions.caffeine
    gnomeExtensions.forge
    gnomeExtensions.logo-menu
    gnomeExtensions.stocks-extension

    (pkgs.writeShellScriptBin "gnome-extensions-loader" ''
      # wait for desktop session to be ready
      sleep 5

      # --- forge extension bug fix ---
      # create required directories and stub files to prevent permission errors
      mkdir -p $HOME/.config/forge
      if [ ! -f $HOME/.config/forge/stylesheet.css ]; then
        touch $HOME/.config/forge/stylesheet.css
      fi

      # --- load dconf settings ---
      # iterate through dconf files and apply configurations
      CONFIG_DIR="/etc/gnome-config"
      if [ -d "$CONFIG_DIR" ]; then
        for f in "$CONFIG_DIR"/*.dconf; do
          [ -e "$f" ] || continue
          ${pkgs.dconf}/bin/dconf load / < "$f"
        done
      fi
    '')
  ];

  # --- dconf configuration source ---
  # link local configuration directory to system path
  environment.etc."gnome-config".source = ./gnome-extensions-config;

  # --- xdg autostart configuration ---
  # trigger the loader script automatically upon user login
  environment.etc."xdg/autostart/gnome-extensions-loader.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Gnome Extensions Loader
    Exec=gnome-extensions-loader
    NoDisplay=true
    X-GNOME-Autostart-enabled=true
  '';
}