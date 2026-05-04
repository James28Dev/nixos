{ config, lib, pkgs, ... }:

{
  # --- Node.js Stack ---
  environment.systemPackages = with pkgs; [
    nodejs
  ];

  # --- Global NPM Config ---
  environment.sessionVariables = {
    PATH = [ "$HOME/.npm-global/bin" ];
  };
}