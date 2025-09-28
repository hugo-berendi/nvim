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
          ];
          
          shellHook = ''
            echo "Hugo's Neovim development environment"
            echo "Use 'nix run .' to run neovim with the configuration"
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