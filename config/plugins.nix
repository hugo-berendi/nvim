{ config, lib, pkgs, ... }:
{
  vim = {
    # Extra plugins configuration
    extraPlugins = with pkgs.vimPlugins; [
      # Mini.nvim suite - comprehensive plugin collection
      mini-nvim
      
      # Which-key for keybinding help
      which-key-nvim
      
      # Additional useful plugins
      plenary-nvim
      nvim-web-devicons
      lspkind-nvim
    ];
    
    # Configure mini.nvim modules via Lua
    luaConfigRC.mini-config = ''
      -- Mini.nvim configuration
      require('mini.ai').setup() -- Better text objects
      require('mini.align').setup() -- Text alignment
      require('mini.animate').setup() -- Smooth animations
      require('mini.basics').setup({
        options = {
          basic = true,
          extra_ui = true,
          win_borders = 'rounded'
        },
        mappings = {
          basic = true,
          option_toggle_prefix = [[\]],
        },
      })
      require('mini.bracketed').setup() -- Bracket navigation
      require('mini.clue').setup() -- Show keybinding hints
      require('mini.comment').setup() -- Smart commenting
      require('mini.completion').setup() -- Auto completion
      require('mini.cursorword').setup() -- Highlight word under cursor
      require('mini.diff').setup() -- Git diff in signs
      require('mini.extra').setup() -- Extra modules
      require('mini.files').setup() -- File explorer
      require('mini.fuzzy').setup() -- Fuzzy matching
      require('mini.git').setup() -- Git integration
      require('mini.hipatterns').setup() -- Highlight patterns
      require('mini.indentscope').setup() -- Indent guides with scope
      require('mini.jump').setup() -- Jump to any location
      require('mini.jump2d').setup() -- 2D jumping
      require('mini.misc').setup() -- Miscellaneous utilities
      require('mini.move').setup() -- Move text around
      require('mini.notify').setup() -- Better notifications
      require('mini.operators').setup() -- Additional operators
      require('mini.pairs').setup() -- Auto pairs
      require('mini.pick').setup() -- Picker (fuzzy finder)
      require('mini.splitjoin').setup() -- Split/join constructs
      require('mini.starter').setup() -- Start screen
      require('mini.surround').setup() -- Surround actions
      require('mini.tabline').setup() -- Tabline
      require('mini.trailspace').setup() -- Trailing whitespace
    '';
    
    # File explorer using mini.files
    filetree = {
      nvimTree = {
        enable = false; # We'll use mini.files instead
      };
    };
    
    # Terminal integration
    terminal = {
      toggleterm = {
        enable = true;
        mappings = {
          open = "<C-t>";
          close = "<C-t>";
        };
        direction = "horizontal";
        enable_winbar = true;
      };
    };
    
    # Telescope for additional fuzzy finding
    telescope = {
      enable = true;
      mappings = {
        findFiles = "<leader>ff";
        liveGrep = "<leader>fg";
        findBuffers = "<leader>fb";
        helpTags = "<leader>fh";
        open = "<leader>ft";
      };
    };
  };
}