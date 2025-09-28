{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Development tools
    lua-language-server
    stylua
    nixd
    nixfmt-rfc-style
    
    # AI tools
    ollama
    curl
    
    # Our custom neovim
    (import ./flake.nix).packages.${system}.default
  ];
  
  shellHook = ''
    echo "Hugo's Neovim development shell with AI"
    echo "Run 'nvim' to start neovim with the custom configuration"
    echo "Or run 'nix run .' to use the flake directly"
    echo ""
    echo "AI Setup:"
    echo "1. Start Ollama: ollama serve"
    echo "2. Pull model: ollama pull codellama:7b-instruct"
    echo "3. Use <leader>aa in neovim to ask AI questions"
  '';
}