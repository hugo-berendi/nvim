{ config, lib, pkgs, ... }:
{
  vim = {
    # Git integration
    git = {
      enable = true;
      gitsigns = {
        enable = true;
        codeActions.enable = true;
      };
    };
    
    # Additional git-related configuration
    luaConfigRC.git-config = ''
      -- Enhanced git configuration with mini.git
      require('mini.git').setup({
        -- Git command timeout
        command = { timeout = 3000 },
        
        -- Job management
        job = { git_executable = 'git', timeout = 30000 },
        
        -- Customize git command behavior
        git = {
          default_timeout = 5000,
        },
      })
      
      -- Git-related keybindings
      local opts = { noremap = true, silent = true }
      
      -- Git status and operations
      vim.keymap.set('n', '<leader>gs', ':Gitsigns toggle_signs<CR>', { desc = "Toggle git signs" })
      vim.keymap.set('n', '<leader>gb', ':Gitsigns blame_line<CR>', { desc = "Git blame line" })
      vim.keymap.set('n', '<leader>gd', ':Gitsigns diffthis<CR>', { desc = "Git diff current file" })
      vim.keymap.set('n', '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = "Reset git hunk" })
      vim.keymap.set('n', '<leader>gR', ':Gitsigns reset_buffer<CR>', { desc = "Reset git buffer" })
      vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', { desc = "Preview git hunk" })
      
      -- Navigate git hunks
      vim.keymap.set('n', ']g', ':Gitsigns next_hunk<CR>', { desc = "Next git hunk" })
      vim.keymap.set('n', '[g', ':Gitsigns prev_hunk<CR>', { desc = "Previous git hunk" })
      
      -- Stage hunks in visual mode
      vim.keymap.set('v', '<leader>gs', ':Gitsigns stage_hunk<CR>', { desc = "Stage git hunk" })
      vim.keymap.set('v', '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = "Reset git hunk" })
    '';
  };
}