return {
    {
  'stevearc/oil.nvim',
  opts = {},
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  lazy = false,
}
}
