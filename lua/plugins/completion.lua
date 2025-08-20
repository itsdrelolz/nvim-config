return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    build = "cargo build --release",
    event = "InsertEnter",
    config = function()
      require("blink.cmp").setup({
        fuzzy = {
          implementation = "lua", -- Use Lua implementation to avoid Rust requirement
        },
        snippets = {
          preset = "luasnip",
        },
        sources = {
          default = { "lsp", "snippets" },
        },
        keymap = {
          preset = "default",
          ["<C-k>"] = { "select_prev" },
          ["<C-j>"] = { "select_next" },
          ["<CR>"] = { "accept" },
          ['<C-Enter>'] = { "accept" },
        },
      })
    end,
  },
}
