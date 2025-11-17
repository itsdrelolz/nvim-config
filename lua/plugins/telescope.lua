return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
      },
      "nvim-tree/nvim-web-devicons",
    },

    keys = {
      { "<leader>pf", function() require("telescope.builtin").find_files() end, desc = "Find project files" },
      { "<C-p>", function() require("telescope.builtin").git_files() end, desc = "Find git files" },
      { "<leader>ps", function() require("telescope.builtin").live_grep() end, desc = "Grep for string" },
    },

    config = function()
      local telescope = require("telescope")

      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      telescope.load_extension("fzf")
    end,
  },
}

