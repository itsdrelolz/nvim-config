local lspconfig = require('lspconfig')
local lsp_zero = require('lsp-zero')
local cmp = require('cmp')

-- Diagnostic configuration
vim.diagnostic.config({
    virtual_text = true,  -- Show error messages inline
    signs = true,         -- Show signs in the gutter
    underline = true,     -- Underline errors
    update_in_insert = false,
    severity_sort = true,
})

-- Existing configurations remain the same
cmp.setup({
    mapping = {
        ['<C-Enter>'] = cmp.mapping.confirm({ select = true }), 
    }
})

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
    
    -- Add additional diagnostic keymaps
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {buffer = bufnr, desc = "Show line diagnostics"})
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {buffer = bufnr, desc = "Previous diagnostic"})
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {buffer = bufnr, desc = "Next diagnostic"})
end)

-- Customize gopls configuration to include more detailed diagnostics
lspconfig.gopls.setup({
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
            diagnosticsDelay = "500ms",
            completeUnimported = true,
            usePlaceholders = true,
        }
    },
    on_attach = function(client, bufnr)
        lsp_zero.on_attach(client, bufnr)
        
        -- Additional gopls-specific diagnostic configuration
        vim.api.nvim_create_autocmd("CursorHold", {
            buffer = bufnr,
            callback = function()
                vim.diagnostic.open_float(nil, {
                    focusable = false,
                    close_events = {
                        "CursorMoved",
                        "CursorMovedI",
                        "BufHidden",
                        "InsertCharPre",
                        "WinLeave",
                    },
                    source = "always",
                    scope = "cursor",
                    max_width = 80,
                })
            end
        })
    end
})

-- Existing language server configurations...


-- Add clangd for C/C++
lspconfig.clangd.setup({
  on_attach = lsp_zero.on_attach, -- Use the same on_attach function as other LSPs
  capabilities = lsp_zero.capabilities, -- Use the same capabilities as other LSPs
  cmd = { "clangd" }, -- Ensure clangd is in your PATH
  filetypes = { "c", "cpp" }, -- File types to associate with clangd
  settings = {
  },
})

-- Add rust-analyzer for Rust
lspconfig.rust_analyzer.setup({
  on_attach = lsp_zero.on_attach,
  capabilities = lsp_zero.capabilities,
  settings = {
    ["rust-analyzer"] = {
    },
  },
})

-- Replace the deprecated tsserver with ts_ls for TypeScript support
require'lspconfig'.ts_ls.setup({
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
        languages = {"javascript", "typescript", "vue"},
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact", 
    "vue", 
  },
})

require'lspconfig'.emmet_language_server.setup({})
require'lspconfig'.eslint.setup({
 --- ...
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

require'lspconfig'.html.setup{}
