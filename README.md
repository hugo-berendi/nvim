# nvim
My custom neovim config created using nvf and nix

## Features

- **Theme**: Rosé Pine Moon - Beautiful, warm theme
- **Plugin Suite**: Primarily uses `mini.nvim` for comprehensive functionality
- **AI Integration**: GitHub Copilot for intelligent code completion
- **Modern UI**: Enhanced with better notifications, status line, and buffer management
- **Fuzzy Finding**: Telescope for powerful searching capabilities

## Quick Start

### Using Nix Flakes (Recommended)

```bash
# Try it out without installing
nix run github:hugo-berendi/nvim

# Or clone and run locally
git clone https://github.com/hugo-berendi/nvim.git
cd nvim
nix run .
```

### Development Shell

```bash
# Enter development environment
nix develop

# Or use shell.nix
nix-shell
```

## Key Features

### Mini.nvim Integration
This configuration makes extensive use of the `mini.nvim` plugin suite, providing:
- Smart completion with `mini.completion`
- File explorer with `mini.files`
- Text objects with `mini.ai`
- Fuzzy finding with `mini.pick`
- Git integration with `mini.git`
- And many more mini modules for a cohesive experience

### Language Server Protocol (LSP)
Comprehensive LSP support for multiple languages:
- **Nix** (nixd)
- **Lua** (lua-language-server)
- **TypeScript/JavaScript** (tsserver)
- **Python** (pyright)
- **Rust** (rust-analyzer)
- **Go** (gopls)
- **HTML/CSS/JSON** (vscode-langservers-extracted)
- **YAML** (yaml-language-server)
- **Markdown** (marksman)

### Git Integration
- **Gitsigns**: Visual git diff indicators
- **Mini.git**: Enhanced git operations
- **Git navigation**: Jump between hunks with ]g and [g
- **Git commands**: Stage, reset, preview hunks

### AI-Powered Development
- **GitHub Copilot**: Intelligent code suggestions
- **Tab Completion**: AI-powered completions (Ctrl+J to accept)
- **Smart Navigation**: Jump between suggestions with Ctrl+] and Ctrl+[

### Key Bindings

#### Leader Key Mappings (Space)
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>e` - File explorer (Mini.files)
- `<leader>w` - Save file
- `<leader>q` - Quit

#### Git Controls
- `<leader>gs` - Toggle git signs / Git status
- `<leader>gb` - Git blame current line
- `<leader>gd` - Git diff current file
- `<leader>gr` - Reset git hunk
- `<leader>gR` - Reset entire buffer
- `<leader>gp` - Preview git hunk
- `]g` - Next git hunk
- `[g` - Previous git hunk

#### Copilot Controls
- `<C-j>` - Accept Copilot suggestion (Insert mode)
- `<C-]>` - Next suggestion (Insert mode)
- `<C-[>` - Previous suggestion (Insert mode)
- `<leader>cs` - Copilot status
- `<leader>ce` - Enable Copilot
- `<leader>cd` - Disable Copilot

#### Window Navigation
- `<C-h/j/k/l>` - Move between windows
- `<C-Arrow Keys>` - Resize windows

## Configuration Structure

```
config/
├── default.nix    # Main module imports
├── vim.nix        # Basic vim settings
├── theme.nix      # Rosé Pine theme configuration
├── plugins.nix    # Mini.nvim and other plugins
├── lsp.nix        # Language Server Protocol configuration
├── git.nix        # Git integration with mini.git and gitsigns
├── ai.nix         # AI/Copilot configuration
└── keybinds.nix   # Custom keybindings
```

## Customization

To customize this configuration:

1. Fork this repository
2. Modify the files in the `config/` directory
3. Run `nix run .` to test your changes
4. Optionally, add your customizations to your system flake

## Requirements

- Nix with flakes enabled
- For Copilot: GitHub account and Copilot subscription

## License

GPL-3.0 - See LICENSE file for details
