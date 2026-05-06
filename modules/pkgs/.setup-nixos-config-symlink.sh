#!/usr/bin/env bash
# sudo bash .setup-nixos-config-symlink.sh 

USER_OWNER=${SUDO_USER:-$(whoami)}
TARGET_DIR="/home/${USER_OWNER}/nixos"
SOURCE_DIR="/etc/nixos"
GROUP_OWNER="users"

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit
fi

# --- Phase 1: Migration Setup ---
if [ -d "$SOURCE_DIR" ] && [ ! -L "$SOURCE_DIR" ]; then
    echo "Found real $SOURCE_DIR. Preparing to migrate..."
    
    mkdir -p "$TARGET_DIR"

    # --- Phase 2: Hardware Config Persistence ---
    if [ -f "$SOURCE_DIR/hardware-configuration.nix" ] && [ ! -f "$TARGET_DIR/hardware-configuration.nix" ]; then
        echo "Copying hardware-configuration.nix to $TARGET_DIR..."
        cp "$SOURCE_DIR/hardware-configuration.nix" "$TARGET_DIR/hardware-configuration.nix"
        chown $USER_OWNER:$GROUP_OWNER "$TARGET_DIR/hardware-configuration.nix"
    fi

    # --- Phase 3: Directory Cleanup ---
    echo "Backing up original $SOURCE_DIR to $SOURCE_DIR.bak"
    mv "$SOURCE_DIR" "$SOURCE_DIR.bak"
fi

# --- Phase 4: Symbolic Link Creation ---
if [ ! -L "$SOURCE_DIR" ]; then
    echo "Creating symlink $SOURCE_DIR -> $TARGET_DIR"
    ln -s "$TARGET_DIR" "$SOURCE_DIR"
    echo "Migration complete!"
else
    echo "Symlink already exists. Nothing to do."
fi
