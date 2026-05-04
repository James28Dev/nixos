{
  description = "James's Multi-Machine NixOS Flake";

  # --- External Resources & Libraries ---
  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };

  # --- System Output Definitions ---
  outputs = { self, nixpkgs, ... } @inputs: {
    nixosConfigurations = {
      # --- PC Setup (GTX 1050) ---
      pc = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration.nix ];
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
      };

      # --- ROG Setup (GTX 1650 Ti) ---
      rog = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          # --- Safety First NVIDIA driver ---
          # ./modules/drivers/nvidia-gtx1650ti-g14-hybrid.nix
        ];
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
      };
    };
  };
}