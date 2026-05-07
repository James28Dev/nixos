{ config, lib, pkgs, ... }:

{
  # --- Shell Tools & Prompt ---
  environment.systemPackages = with pkgs; [ oh-my-posh ];

  # --- Fish Shell Configuration ---
  programs.fish.enable = true;

  # --- Interactive Shell Initialization ---
  # Other themes: montys, paradox.
  programs.fish.interactiveShellInit = ''oh-my-posh init fish --config ${../oh-my-posh-themes/craver.omp.json} | source'';}