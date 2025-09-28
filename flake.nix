{
  description = "Hugo's custom neovim configuration using nvf";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # NVF (Neovim Flake)
    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
    
    # Flake utilities
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nvf, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        # Custom neovim configuration
        neovimConfig = nvf.lib.neovimConfiguration {
          modules = [
            ./config
          ];
          pkgs = pkgs;
        };
      in
      {
        # Main neovim package
        packages.default = neovimConfig.neovim;
        packages.neovim = neovimConfig.neovim;
        
        # Development shell
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Language servers and tools for development
            lua-language-server
            stylua
            nixd
            nixfmt-rfc-style
            
            # AI tools
            ollama  # Required for Avante.nvim AI chat
            curl    # Required for Ollama API calls
          ];
          
          shellHook = ''
            echo "Hugo's Neovim development environment with Avante AI"
            echo "Use 'nix run .' to run neovim with the configuration"
            echo ""
            echo "AI Setup:"
            echo "1. Start Ollama server: ollama serve"
            echo "2. Pull AI model: ollama pull codellama:7b-instruct"
            echo "3. Open neovim and use <leader>aa to ask AI questions"
          '';
        };
        
        # Apps
        apps.default = {
          type = "app";
          program = "${neovimConfig.neovim}/bin/nvim";
        };
        apps.neovim = {
          type = "app";
          program = "${neovimConfig.neovim}/bin/nvim";
        };
      }
    );
}