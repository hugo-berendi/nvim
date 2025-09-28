{ config, lib, pkgs, ... }:
{
  vim = {
    # Theme configuration - Rosé Pine Moon
    theme = {
      enable = true;
      name = "rose-pine";
      style = "moon"; # Use the moon variant
      transparent = false;
    };
    
    # Additional UI settings
    ui = {
      borders = "rounded";
      noice = {
        enable = true; # Better command line, notifications, etc.
      };
    };
    
    # Status line and tab line
    statusline = {
      lualine = {
        enable = true;
        theme = "rose-pine";
        globalstatus = true;
        refresh = {
          statusline = 1000;
          tabline = 1000;
          winbar = 1000;
        };
      };
    };
    
    # Tabline/bufferline
    tabline = {
      nvimBufferline = {
        enable = true;
        mappings = {
          cycleNext = "<Tab>";
          cyclePrevious = "<S-Tab>";
          closeCurrent = "<leader>bd";
        };
      };
    };
  };
}