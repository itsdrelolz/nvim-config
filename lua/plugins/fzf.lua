return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>pf", function() require('fzf-lua').files() end, desc = "Find project files" },
    { "<C-p>", function() require('fzf-lua').git_files() end, desc = "Find git files" },
    { "<leader>ps", function() require('fzf-lua').grep_project() end, desc = "Grep for string" },
  },
  config = function()
    require("fzf-lua").setup({})
  end
}
