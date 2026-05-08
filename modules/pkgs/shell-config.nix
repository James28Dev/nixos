{ config, lib, pkgs, ... }:

let
  # Choose your desired theme: craver, montys, paradox
  selectedTheme = "craver";
in

{
  # --- Shell Tools & Prompt ---
  environment.systemPackages = with pkgs; [ oh-my-posh ];

  # --- Fish Shell Configuration ---
  programs.fish.enable = true;

  # --- Interactive Shell Initialization ---
  programs.fish.interactiveShellInit = ''oh-my-posh init fish --config ${../oh-my-posh-themes/${selectedTheme}.omp.json} | source'';
}