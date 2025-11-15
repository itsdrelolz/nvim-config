return {
  -- Mason: installs language servers
  {
"mason-org/mason.nvim",
    opts = {}
  },

  -- Mason-LSPConfig: bridges Mason and nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local on_attach = function(_, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        -- Buffer-local LSP mappings (triggered after LSP attaches)
        map("gd", vim.lsp.buf.definition, "Go to Definition")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gr", vim.lsp.buf.references, "Go to References")
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
          -- Default handler for all LSPs
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,

          -- Lua
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = "LuaJIT" },
                  diagnostics = { globals = { "vim" } },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                  },
                  telemetry = { enable = false },
                },
              },
            })
          end,

          -- TypeScript/JavaScript
          ["ts_ls"] = function()
            require("lspconfig").ts_ls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
            })
          end,

          -- Python
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

          -- Go
          ["gopls"] = function()
            require("lspconfig").gopls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                gopls = {
                  analyses = { unusedparams = true },
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

