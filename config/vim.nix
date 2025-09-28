{ config, lib, pkgs, ... }:
{
  # Basic vim settings
  vim = {
    # Use viAlias and vimAlias to provide vi and vim aliases
    viAlias = true;
    vimAlias = true;

    # Basic editor settings  
    lineNumberMode = "relNumber";
    syntaxHighlighting = true;
    useSystemClipboard = true;
    autoIndent = true;
    
    # Tab settings
    tabWidth = 2;
    expandTab = true;
    
    # Search settings
    search = {
      wrapscan = true;
      incsearch = true;
      ignorecase = true;
      smartcase = true;
    };
    
    # Editor behavior
    wordWrap = true;
    enableEditorconfig = true;
    spellcheck = {
      enable = false; # Can be enabled per filetype if needed
    };
    
    # Undo settings
    undoFile = {
      enable = true;
    };
    
    # Auto commands and basic settings
    globals = {
      mapleader = " "; # Space as leader key
      maplocalleader = ",";
    };
  };
}