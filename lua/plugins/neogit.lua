return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    },
  cmd = "Neogit",
  keys = {
    { "<leader>gs", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
  }
}
