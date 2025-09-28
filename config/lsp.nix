{ config, lib, pkgs, ... }:
{
  vim = {
    # Language Server Protocol (LSP) configuration
    lsp = {
      enable = true;
      formatOnSave = true;
      lspkind.enable = true;
      lightbulb.enable = true;
      lspsaga.enable = false; # We'll use mini.nvim instead
      nvimCodeActionMenu.enable = true;
      trouble.enable = true;
      lspSignature.enable = true;
      
      servers = {
        # Nix
        nixd = {
          enable = true;
          package = pkgs.nixd;
        };
        
        # Lua
        lua-ls = {
          enable = true;
          package = pkgs.lua-language-server;
        };
        
        # TypeScript/JavaScript  
        tsserver = {
          enable = true;
          package = pkgs.nodePackages.typescript-language-server;
        };
        
        # Python
        pyright = {
          enable = true;
          package = pkgs.pyright;
        };
        
        # Rust
        rust-analyzer = {
          enable = true;
          package = pkgs.rust-analyzer;
        };
        
        # Go
        gopls = {
          enable = true;
          package = pkgs.gopls;
        };
        
        # HTML/CSS
        html = {
          enable = true;
          package = pkgs.vscode-langservers-extracted;
        };
        
        cssls = {
          enable = true;
          package = pkgs.vscode-langservers-extracted;
        };
        
        # JSON
        jsonls = {
          enable = true;
          package = pkgs.vscode-langservers-extracted;
        };
        
        # YAML
        yamlls = {
          enable = true;
          package = pkgs.yaml-language-server;
        };
        
        # Markdown
        marksman = {
          enable = true;
          package = pkgs.marksman;
        };
      };
    };
    
    # TreeSitter for better syntax highlighting
    treesitter = {
      enable = true;
      fold = true;
      indent = true;
      addDefaultGrammars = true;
      
      grammars = [
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.nix
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.lua
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.typescript
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.javascript
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.python
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.rust
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.go
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.html
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.css
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.json
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.yaml
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.markdown
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.bash
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.vim
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.dockerfile
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.toml
      ];
    };
    
    # Formatting
    formatter = {
      enable = true;
      
      # Language-specific formatters
      filetype = {
        nix = {
          command = "nixfmt";
          package = pkgs.nixfmt-rfc-style;
        };
        
        lua = {
          command = "stylua";
          package = pkgs.stylua;
        };
        
        typescript = {
          command = "prettier";
          package = pkgs.nodePackages.prettier;
        };
        
        javascript = {
          command = "prettier";
          package = pkgs.nodePackages.prettier;
        };
        
        python = {
          command = "black";
          package = pkgs.python3Packages.black;
        };
        
        rust = {
          command = "rustfmt";
          package = pkgs.rustfmt;
        };
        
        go = {
          command = "gofmt";
        };
        
        json = {
          command = "prettier";
          package = pkgs.nodePackages.prettier;
        };
        
        yaml = {
          command = "prettier";
          package = pkgs.nodePackages.prettier;
        };
        
        markdown = {
          command = "prettier";
          package = pkgs.nodePackages.prettier;
        };
      };
    };
  };
}