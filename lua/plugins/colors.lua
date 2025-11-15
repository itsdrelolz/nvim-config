return {
  "thesimonho/kanagawa-paper.nvim",

  priority = 1000, 
  opts = {
    options = {
      transparent = true, 
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  config = function(_, opts)
    require("kanagawa-paper").setup(opts)
    vim.cmd.colorscheme "kanagawa-paper" 
  end,
}
