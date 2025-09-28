{ config, lib, pkgs, ... }:
{
  # Import all configuration modules
  imports = [
    ./vim.nix
    ./theme.nix
    ./plugins.nix
    ./ai.nix
    ./keybinds.nix
  ];
}