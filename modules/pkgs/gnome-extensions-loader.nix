{ config, lib, pkgs, ... }:

{
  # --- system packages & custom loader script ---
  environment.systemPackages = with pkgs; [
    gnome-extension-manager
    gnome-tweaks
    # --- Gnome Extensions ---
    gnomeExtensions.blur-my-shell
    gnomeExtensions.burn-my-windows
    gnomeExtensions.caffeine
    gnomeExtensions.logo-menu
    gnomeExtensions.paperwm
    gnomeExtensions.stocks-extension

    (pkgs.writeShellScriptBin "gnome-extensions-loader" ''
      # wait for desktop session to be ready
      sleep 5

      # --- burn-my-windows extension profile setup ---
      # create directory and copy profile from nix store to home
      mkdir -p $HOME/.config/burn-my-windows/profiles
      cp $HOME/nixos/modules/pkgs/gnome-extensions-config/burn-my-windows.conf $HOME/.config/burn-my-windows/profiles/default.conf

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