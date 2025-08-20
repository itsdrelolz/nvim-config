return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    event = "InsertEnter",
    config = function()
      require("blink").setup({
        snippets = {
          expand = function(snippet, _)
            require("luasnip").lsp_expand(snippet.body)
          end,
        },
        sources = {
          default = { "lsp", "luasnip" },
        },
        keymap = {
          preset = "insert",
          ["<C-k>"] = { "select_prev" },
          ["<C-j>"] = { "select_next" },
          ["<CR>"] = { "accept" },
          ['<C-Enter>'] = { "accept" },
        },
      })
    end,
  },
}
