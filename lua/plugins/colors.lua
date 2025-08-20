return {
  {
    "neanias/everforest-nvim",
    priority = 1000, -- Make sure it loads first
    config = function()
      require("everforest").setup({
        -- You can configure the theme here if you wish
        transparent_background = true,
      })
      vim.cmd.colorscheme "everforest"
    end,
  },
}
