return {
  -- LSP Configuration & Mason
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    config = function()
      -- Get capabilities from blink.cmp
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      
      local on_attach = function(client, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end
        map("gd", vim.lsp.buf.definition, "Go to Definition")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("gr", vim.lsp.buf.references, "Go to References")
        map("<leader>d", vim.diagnostic.open_float, "Show Diagnostics")
        map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
        map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
      end
      
      local servers = {
        "lua_ls",
        "ts_ls",
        "gopls",
        "pyright",
        "html",
        "cssls",
      }
      
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        handlers = {
          -- Default handler for all LSPs not explicitly configured
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,
          
          -- Lua LSP configuration
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = {
                    version = 'LuaJIT'
                  },
                  diagnostics = {
                    globals = {'vim'}
                  },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                  },
                  telemetry = {
                    enable = false,
                  },
                },
              },
            })
          end,
          
          -- TypeScript/JavaScript LSP configuration
          ["ts_ls"] = function()
            require("lspconfig").ts_ls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
            })
          end,
          
          -- Vue LSP configuration
          ["vue_ls"] = function()
            require("lspconfig").vue_ls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              filetypes = { "vue" },
            })
          end,
          
          -- Python LSP configuration
          ["pyright"] = function()
            require("lspconfig").pyright.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                python = {
                  analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                  },
                },
              },
            })
          end,
          
          -- Go LSP configuration
          ["gopls"] = function()
            require("lspconfig").gopls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                gopls = {
                  analyses = {
                    unusedparams = true,
                  },
                  staticcheck = true,
                  gofumpt = true,
                },
              },
            })
          end,
        },
      })
    end,
  },
}
