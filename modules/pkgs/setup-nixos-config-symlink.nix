{ config, lib, pkgs, ... }:

{
  system.activationScripts.setupNixosConfig = {
    text = ''
      # --- Phase 1: Migration Setup ---
      # Verify that /etc/nixos is a real folder (not a link) in preparation for migrating it to your Home directory.
      if [ -d "/etc/nixos" ] && [ ! -L "/etc/nixos" ]; then
        echo "Found real /etc/nixos. Preparing to migrate..."

        # --- Phase 2: Hardware Config Persistence ---
        # Copy the hardware files from the system to ~/nixos (only do this if these files don't already exist in ~/nixos).
        if [ -f "/etc/nixos/hardware-configuration.nix" ] && [ ! -f "/home/james/nixos/hardware-configuration.nix" ]; then
          echo "Copying hardware-configuration.nix to ~/nixos..."
          cp /etc/nixos/hardware-configuration.nix /home/james/nixos/hardware-configuration.nix
          chown james:users /home/james/nixos/hardware-configuration.nix
        fi

        # --- Phase 3: Directory Cleanup ---
        # Back up the original file in .bak format for security.
        mv /etc/nixos /etc/nixos.bak
      fi

      # --- Phase 4: Symbolic Link Creation ---
      # Create a  symlink between the system and the work folder in the Home Directory.
      if [ ! -L "/etc/nixos" ]; then
        echo "Creating symlink /etc/nixos -> /home/james/nixos"
        ln -s /home/james/nixos /etc/nixos
      fi
    '';
  };
}
