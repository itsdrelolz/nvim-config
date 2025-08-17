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
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local on_attach = function(client, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end
        map("gd", vim.lsp.buf.definition, "Go to Definition")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
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
      })

      for _, server_name in ipairs(servers) do
        require("lspconfig")[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end,
  },

  -- Autocompletion Engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          -- Keymap from remap.lua is now here
          ['<C-Enter>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }),
      })
    end,
  },
}
