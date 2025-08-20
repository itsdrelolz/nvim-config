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
      -- Get capabilities from blink.cmp instead of cmp-nvim-lsp
      local capabilities = require('blink.cmp').get_lsp_capabilities()

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
        "csharp_ls",
      }

      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })

      -- Pass blink.cmp capabilities to each server
      for _, server_name in ipairs(servers) do
        require("lspconfig")[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end,
  },
}
