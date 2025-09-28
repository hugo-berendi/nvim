{ config, lib, pkgs, ... }:
{
  vim = {
    # AI and completion plugins
    extraPlugins = with pkgs.vimPlugins; [
      # GitHub Copilot for AI completions
      copilot-vim
      
      # Additional completion sources
      cmp-buffer
      cmp-path
      cmp-nvim-lsp
      cmp-luasnip
      luasnip
      friendly-snippets
    ];
    
    # Enhanced completion configuration
    autocomplete = {
      nvim-cmp = {
        enable = true;
        sources = {
          nvim_lsp = "[LSP]";
          buffer = "[Buffer]";
          path = "[Path]";
          luasnip = "[Snippet]";
        };
        mappings = {
          complete = "C-Space";
          confirm = "CR";
          next = "Tab";
          previous = "S-Tab";
          close = "C-e";
          scrollDocsUp = "C-u";
          scrollDocsDown = "C-d";
        };
      };
    };
    
    # Lua configuration for AI features
    luaConfigRC.ai-config = ''
      -- GitHub Copilot settings
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      
      -- Custom keybindings for AI features
      local opts = { noremap = true, silent = true }
      
      -- Copilot accept with Ctrl+J (avoiding Tab conflicts)
      vim.keymap.set('i', '<C-J>', function()
        if vim.fn['copilot#Accept']("") ~= "" then
          return vim.fn['copilot#Accept']("")
        else
          return "<C-J>"
        end
      end, { expr = true, replace_keycodes = false })
      
      -- Copilot cycling
      vim.keymap.set('i', '<C-]>', '<Plug>(copilot-next)', opts)
      vim.keymap.set('i', '<C-[>', '<Plug>(copilot-previous)', opts)
      vim.keymap.set('i', '<C-\\>', '<Plug>(copilot-dismiss)', opts)
      
      -- Show/hide Copilot suggestions
      vim.keymap.set('n', '<leader>cs', ':Copilot status<CR>', { desc = "Copilot status" })
      vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>', { desc = "Disable Copilot" })
      vim.keymap.set('n', '<leader>ce', ':Copilot enable<CR>', { desc = "Enable Copilot" })
    '';
  };
}