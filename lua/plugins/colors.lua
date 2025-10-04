return {
  -- 1. Change the repository name
  "EdenEast/nightfox.nvim",

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
    -- 2. Call the new setup function
    require("nightfox").setup(opts)
    
    vim.cmd.colorscheme "nightfox" 
  end,
}
