# Changelog

## [1.1.0] - 2024-12-28

### Changed
- **AI System Migration**: Replaced GitHub Copilot with Avante.nvim for local AI chat using Ollama
- **Privacy Enhancement**: AI now runs completely locally through Ollama - no external API calls
- **Enhanced AI Interaction**: Added interactive chat interface with dedicated panel
- **New Keybindings**: Updated AI keybindings to use `<leader>a*` prefix for Avante commands

### Added
- **Avante.nvim Integration**: Full AI chat interface with Ollama backend
- **Local AI Models**: Support for CodeLlama, Llama2, Mistral, and other Ollama models
- **AI Chat Panel**: Dedicated sidebar for AI conversations and code assistance
- **Enhanced AI Commands**: Generate tests, documentation, code explanations, and optimizations
- **Ollama Integration**: Automatic Ollama inclusion in development shell

### Removed
- GitHub Copilot integration (replaced by Avante.nvim + Ollama)
- External AI API dependencies

## [1.0.0] - 2024-12-28

### Added
- Initial Nix flake configuration using nvf (Neovim Flake)
- Rosé Pine Moon theme integration
- Comprehensive mini.nvim plugin suite integration
- GitHub Copilot AI code completion support
- Language Server Protocol (LSP) support for multiple languages:
  - Nix, Lua, TypeScript/JavaScript, Python, Rust, Go, HTML, CSS, JSON, YAML, Markdown
- Git integration with gitsigns and mini.git
- TreeSitter syntax highlighting with multiple language grammars
- Code formatting with language-specific formatters
- Development shell with essential tools
- GitHub Actions CI configuration
- Comprehensive keybinding system with which-key hints
- File explorer using mini.files
- Fuzzy finding with Telescope and mini.pick
- Terminal integration with toggleterm
- Modern UI enhancements (status line, buffer line, notifications)

### Features
- **Theme**: Beautiful Rosé Pine Moon colorscheme
- **AI Integration**: GitHub Copilot with smart tab completion
- **Mini.nvim Suite**: 20+ mini modules for comprehensive functionality
- **LSP Support**: Multi-language development environment
- **Git Workflow**: Visual diff indicators and git operations
- **Modern UI**: Lualine status bar, buffer management, rounded borders
- **Smart Navigation**: Window/buffer/git hunk navigation
- **Extensible**: Modular configuration structure for easy customization

### Documentation  
- Comprehensive README with usage examples
- Integration examples for system flakes and home-manager
- Detailed keybinding documentation
- Feature overview and customization guide