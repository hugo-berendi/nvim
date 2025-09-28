{ config, lib, pkgs, ... }:
{
  vim = {
    # AI and completion plugins
    extraPlugins = with pkgs.vimPlugins; [
      # Dependencies for Avante.nvim
      nui-nvim
      nvim-web-devicons
      plenary-nvim
      
      # Additional completion sources
      cmp-buffer
      cmp-path
      cmp-nvim-lsp
      cmp-luasnip
      luasnip
      friendly-snippets
    ];
    
    # Add Avante.nvim via raw Lua configuration since it might not be in nixpkgs yet
    luaConfigRC.avante-setup = ''
      -- Install and setup Avante.nvim
      -- Note: This assumes Avante.nvim is available or can be lazy-loaded
      
      -- Check if avante is available
      local ok, avante = pcall(require, 'avante')
      if ok then
        avante.setup({
          provider = "ollama",
          ollama = {
            endpoint = "http://localhost:11434/v1",
            model = "codellama:7b-instruct",
            parse_curl_args = function(opts, code_opts)
              return {
                url = opts.endpoint .. "/chat/completions",
                headers = {
                  ["Accept"] = "application/json",
                  ["Content-Type"] = "application/json",
                },
                body = {
                  model = opts.model,
                  messages = opts.messages or {},
                  max_tokens = 4096,
                  stream = true,
                },
              }
            end,
            parse_response_data = function(data_stream, event_state, opts)
              -- Simple response parsing - can be enhanced
              if data_stream and data_stream.choices and data_stream.choices[1] then
                return data_stream.choices[1].delta.content or ""
              end
              return ""
            end,
          },
          behaviour = {
            auto_suggestions = true,
            auto_set_highlight_group = true,
            auto_set_keymaps = false, -- We'll set our own keymaps
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
          },
          mappings = {
            diff = {
              ours = "co",
              theirs = "ct",
              all_theirs = "ca",
              both = "cb",
              cursor = "cc",
              next = "]x",
              prev = "[x",
            },
            suggestion = {
              accept = "<M-l>",
              next = "<M-]>",
              prev = "<M-[>",
              dismiss = "<C-]>",
            },
            jump = {
              next = "]]",
              prev = "[[",
            },
          },
          hints = { enabled = true },
          windows = {
            position = "right",
            wrap = true,
            width = 30,
            sidebar_header = {
              align = "center",
              rounded = true,
            },
          },
          highlights = {
            diff = {
              current = "DiffText",
              incoming = "DiffAdd",
            },
          },
        })
      else
        -- Fallback: Create simple AI chat interface using existing tools
        -- This provides basic AI functionality even without Avante.nvim
        
        -- Simple AI chat function using curl and Ollama
        local function ask_ollama(prompt, callback)
          local cmd = string.format(
            'curl -s -X POST http://localhost:11434/api/generate -H "Content-Type: application/json" -d \'{"model": "codellama:7b-instruct", "prompt": "%s", "stream": false}\'',
            prompt:gsub('"', '\\"')
          )
          
          vim.fn.jobstart(cmd, {
            on_stdout = function(_, data)
              if data and #data > 0 then
                local response = table.concat(data, "\n")
                local success, result = pcall(vim.fn.json_decode, response)
                if success and result.response then
                  if callback then callback(result.response) end
                end
              end
            end,
            stdout_buffered = true,
          })
        end
        
        -- Simple AI commands
        vim.api.nvim_create_user_command('AvanteAsk', function(opts)
          local prompt = opts.args
          if prompt == "" then
            prompt = vim.fn.input("Ask AI: ")
          end
          
          if prompt and prompt ~= "" then
            print("Asking AI...")
            ask_ollama(prompt, function(response)
              -- Display response in a new buffer
              local buf = vim.api.nvim_create_buf(false, true)
              vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(response, "\n"))
              vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
              vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
              
              -- Open in a split
              vim.cmd('vsplit')
              vim.api.nvim_win_set_buf(0, buf)
            end)
          end
        end, { nargs = '*' })
        
        vim.api.nvim_create_user_command('AvanteEdit', 'AvanteAsk', { nargs = '*' })
        vim.api.nvim_create_user_command('AvanteChat', 'AvanteAsk', { nargs = '*' })
        vim.api.nvim_create_user_command('AvanteToggle', 'echo "Toggle not available in fallback mode"', {})
        vim.api.nvim_create_user_command('AvanteFocus', 'echo "Focus not available in fallback mode"', {})
        vim.api.nvim_create_user_command('AvanteRefresh', 'echo "Refresh not available in fallback mode"', {})
      end
    '';
    
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
      -- Avante.nvim AI chat configuration
      local opts = { noremap = true, silent = true }
      
      -- Avante AI chat keybindings
      vim.keymap.set('n', '<leader>aa', ':AvanteAsk<CR>', { desc = "Ask Avante AI" })
      vim.keymap.set('v', '<leader>aa', ':AvanteAsk<CR>', { desc = "Ask Avante AI about selection" })
      vim.keymap.set('n', '<leader>ae', ':AvanteEdit<CR>', { desc = "Edit with Avante AI" })
      vim.keymap.set('v', '<leader>ae', ':AvanteEdit<CR>', { desc = "Edit selection with Avante AI" })
      vim.keymap.set('n', '<leader>ac', ':AvanteChat<CR>', { desc = "Open Avante chat" })
      vim.keymap.set('n', '<leader>at', ':AvanteToggle<CR>', { desc = "Toggle Avante panel" })
      vim.keymap.set('n', '<leader>af', ':AvanteFocus<CR>', { desc = "Focus Avante panel" })
      vim.keymap.set('n', '<leader>ar', ':AvanteRefresh<CR>', { desc = "Refresh Avante" })
      
      -- Additional AI-powered operations
      vim.keymap.set('n', '<leader>ag', function()
        vim.cmd('AvanteAsk Generate unit tests for this function')
      end, { desc = "Generate tests with AI" })
      
      vim.keymap.set('n', '<leader>ad', function()
        vim.cmd('AvanteAsk Add documentation for this code')
      end, { desc = "Generate documentation with AI" })
      
      vim.keymap.set('n', '<leader>ao', function()
        vim.cmd('AvanteAsk Optimize this code for better performance')
      end, { desc = "Optimize code with AI" })
      
      vim.keymap.set('n', '<leader>ax', function()
        vim.cmd('AvanteAsk Explain what this code does')
      end, { desc = "Explain code with AI" })
      
      -- Accept AI suggestions with Alt+L (like Copilot's Tab)
      vim.keymap.set('i', '<M-l>', function()
        require('avante.suggestion').accept()
      end, { desc = "Accept AI suggestion" })
      
      -- Navigate AI suggestions
      vim.keymap.set('i', '<M-]>', function()
        require('avante.suggestion').next()
      end, { desc = "Next AI suggestion" })
      
      vim.keymap.set('i', '<M-[>', function()
        require('avante.suggestion').prev()
      end, { desc = "Previous AI suggestion" })
    '';
  };
}