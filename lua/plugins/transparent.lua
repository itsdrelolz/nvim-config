return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  -- Configure the plugin when it loads
  config = function()
    require("transparent").setup({
      -- This is useful if a plugin creates its own windows that aren't transparent.
      -- For example, for `nvim-tree` or `mason`.
      extra_groups = {
        -- For a transparent NvimTree
        "NvimTreeNormal",
        "NvimTreeNormalNC",
        -- For a transparent floating window, such as Lazy's plugin UI
        "NormalFloat",
        -- Add other groups as needed
        -- "your_plugin_group",
      },
    })
  end,
}
