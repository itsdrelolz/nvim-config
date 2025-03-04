local lspconfig = require('lspconfig')
local lsp_zero = require('lsp-zero')
local cmp = require('cmp')

cmp.setup({
    mapping = {
        -- ... other mappings ...
        ['<C-Enter>'] = cmp.mapping.confirm({ select = true }), 
    }
})
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- Add Pyright configuration
lspconfig.pyright.setup({
  -- Pyright specific configurations here
  -- For example:
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- Add gopls configuration
lspconfig.gopls.setup({
  -- gopls specific configurations here
  -- For example:
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

require'lspconfig'.tsserver.setup({
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
