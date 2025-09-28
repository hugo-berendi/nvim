{ config, lib, pkgs, ... }:
{
  vim = {
    # Custom keybindings
    maps = {
      # Normal mode mappings
      normal = {
        # Leader key mappings
        "<leader>w" = { action = ":w<CR>"; desc = "Save file"; };
        "<leader>q" = { action = ":q<CR>"; desc = "Quit"; };
        "<leader>x" = { action = ":x<CR>"; desc = "Save and quit"; };
        
        # Buffer management
        "<leader>bd" = { action = ":bdelete<CR>"; desc = "Delete buffer"; };
        "<leader>bn" = { action = ":bnext<CR>"; desc = "Next buffer"; };
        "<leader>bp" = { action = ":bprevious<CR>"; desc = "Previous buffer"; };
        
        # Window navigation
        "<C-h>" = { action = "<C-w>h"; desc = "Move to left window"; };
        "<C-j>" = { action = "<C-w>j"; desc = "Move to bottom window"; };
        "<C-k>" = { action = "<C-w>k"; desc = "Move to top window"; };
        "<C-l>" = { action = "<C-w>l"; desc = "Move to right window"; };
        
        # Window resizing
        "<C-Up>" = { action = ":resize +2<CR>"; desc = "Increase window height"; };
        "<C-Down>" = { action = ":resize -2<CR>"; desc = "Decrease window height"; };
        "<C-Left>" = { action = ":vertical resize -2<CR>"; desc = "Decrease window width"; };
        "<C-Right>" = { action = ":vertical resize +2<CR>"; desc = "Increase window width"; };
        
        # Clear search highlighting
        "<leader>nh" = { action = ":nohl<CR>"; desc = "Clear search highlights"; };
        
        # Better indenting
        "<" = { action = "<gv"; desc = "Indent left and reselect"; };
        ">" = { action = ">gv"; desc = "Indent right and reselect"; };
        
        # Move text up and down
        "<A-j>" = { action = ":m .+1<CR>=="; desc = "Move line down"; };
        "<A-k>" = { action = ":m .-2<CR>=="; desc = "Move line up"; };
        
        # File explorer (mini.files)
        "<leader>e" = { action = ":lua MiniFiles.open()<CR>"; desc = "Open file explorer"; };
        
        # Copilot controls
        "<leader>cs" = { action = ":Copilot status<CR>"; desc = "Copilot status"; };
        "<leader>ce" = { action = ":Copilot enable<CR>"; desc = "Enable Copilot"; };
        "<leader>cd" = { action = ":Copilot disable<CR>"; desc = "Disable Copilot"; };
      };
      
      # Visual mode mappings
      visual = {
        # Better indenting
        "<" = { action = "<gv"; desc = "Indent left and reselect"; };
        ">" = { action = ">gv"; desc = "Indent right and reselect"; };
        
        # Move text up and down
        "<A-j>" = { action = ":m '>+1<CR>gv=gv"; desc = "Move selection down"; };
        "<A-k>" = { action = ":m '<-2<CR>gv=gv"; desc = "Move selection up"; };
        
        # AI/Copilot on selection  
        "<leader>cs" = { action = ":Copilot status<CR>"; desc = "Copilot status"; };
      };
      
      # Insert mode mappings
      insert = {
        # Exit insert mode
        "jk" = { action = "<ESC>"; desc = "Exit insert mode"; };
        "kj" = { action = "<ESC>"; desc = "Exit insert mode"; };
        
        # Move cursor in insert mode
        "<C-h>" = { action = "<Left>"; desc = "Move cursor left"; };
        "<C-j>" = { action = "<Down>"; desc = "Move cursor down"; };
        "<C-k>" = { action = "<Up>"; desc = "Move cursor up"; };
        "<C-l>" = { action = "<Right>"; desc = "Move cursor right"; };
      };
      
      # Command mode mappings
      command = {
        # Command history navigation
        "<C-j>" = { action = "<Down>"; desc = "Next command"; };
        "<C-k>" = { action = "<Up>"; desc = "Previous command"; };
      };
      
      # Terminal mode mappings
      terminal = {
        # Exit terminal mode
        "<ESC>" = { action = "<C-\\><C-n>"; desc = "Exit terminal mode"; };
        "<C-h>" = { action = "<C-\\><C-n><C-w>h"; desc = "Terminal left window"; };
        "<C-j>" = { action = "<C-\\><C-n><C-w>j"; desc = "Terminal down window"; };
        "<C-k>" = { action = "<C-\\><C-n><C-w>k"; desc = "Terminal up window"; };
        "<C-l>" = { action = "<C-\\><C-n><C-w>l"; desc = "Terminal right window"; };
      };
    };
    
    # Additional Lua keybindings configuration
    luaConfigRC.keybindings = ''
      -- Which-key setup for better keybinding hints
      local wk = require("which-key")
      wk.register({
        ["<leader>"] = {
          c = {
            name = "Copilot",
            s = "Status",
            e = "Enable", 
            d = "Disable",
          },
          f = {
            name = "Find/Telescope",
            f = "Find files",
            g = "Live grep",
            b = "Find buffers",
            h = "Help tags",
            t = "Open telescope",
          },
          g = {
            name = "Git",
            s = "Toggle signs / Status",
            b = "Blame line",
            d = "Diff file", 
            r = "Reset hunk",
            R = "Reset buffer",
            p = "Preview hunk",
          },
          b = {
            name = "Buffer",
            d = "Delete buffer",
            n = "Next buffer",
            p = "Previous buffer",
          },
          w = "Write/Save",
          q = "Quit",
          x = "Save and quit",
          e = "File explorer",
          n = {
            name = "No...",
            h = "No highlight",
          },
        },
        ["]g"] = "Next git hunk",
        ["[g"] = "Previous git hunk",
      })
      
      -- Mini.clue configuration for additional hints
      require('mini.clue').setup({
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },
          
          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },
          
          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },
          
          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },
          
          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },
          
          -- Window commands
          { mode = 'n', keys = '<C-w>' },
          
          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },
        clues = {
          -- Enhance this by adding descriptions for new maps
          require('mini.clue').gen_clues.builtin_completion(),
          require('mini.clue').gen_clues.g(),
          require('mini.clue').gen_clues.marks(),
          require('mini.clue').gen_clues.registers(),
          require('mini.clue').gen_clues.windows(),
          require('mini.clue').gen_clues.z(),
        },
      })
    '';
  };
}