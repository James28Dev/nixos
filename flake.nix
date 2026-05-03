{
  description = "James's NixOS Flake Configuration";

  # --- External Resources & Libraries ---
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  # --- System Output Definitions ---
  outputs = { self, nixpkgs, ... } @inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
      ];
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
    };
  };
}