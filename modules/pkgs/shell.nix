{ config, lib, pkgs, ... }:

{
  # --- Shell Tools & Prompt ---
  environment.systemPackages = with pkgs; [
    oh-my-posh
  ];

  # --- Fish Shell Configuration ---
  programs.fish.enable = true;

  # --- Interactive Shell Initialization ---
  programs.fish.interactiveShellInit = ''
    oh-my-posh init fish --config ${pkgs.oh-my-posh}/share/oh-my-posh/themes/craver.omp.json | source
  '';
}