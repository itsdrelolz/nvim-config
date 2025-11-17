return {
  "sainnhe/gruvbox-material",

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
  config = function()
    vim.g.gruvbox_material_enable_italic = true
    vim.cmd.colorscheme "gruvbox-material" 
  end,
}
