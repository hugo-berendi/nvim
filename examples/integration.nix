# Example integration into a system flake or home-manager
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nvim-config.url = "github:hugo-berendi/nvim";
  };

  outputs = { self, nixpkgs, home-manager, nvim-config, ... }: {
    # System configuration example
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.users.myuser = {
            programs.neovim = {
              enable = false; # Disable default neovim
            };
            home.packages = [
              nvim-config.packages.x86_64-linux.default
            ];
          };
        }
      ];
    };

    # Home manager configuration example  
    homeConfigurations.myuser = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        {
          home.packages = [
            nvim-config.packages.x86_64-linux.default
          ];
          
          # Create a shell alias
          programs.zsh.shellAliases = {
            vim = "${nvim-config.packages.x86_64-linux.default}/bin/nvim";
            vi = "${nvim-config.packages.x86_64-linux.default}/bin/nvim";
          };
        }
      ];
    };
  };
}