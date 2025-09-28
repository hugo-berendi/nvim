{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Development tools
    lua-language-server
    stylua
    nixd
    nixfmt-rfc-style
    
    # Our custom neovim
    (import ./flake.nix).packages.${system}.default
  ];
  
  shellHook = ''
    echo "Hugo's Neovim development shell"
    echo "Run 'nvim' to start neovim with the custom configuration"
    echo "Or run 'nix run .' to use the flake directly"
  '';
}