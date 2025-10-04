return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = "CopilotChat",

    -- *** CRITICAL: ADD THESE MISSING DEPENDENCIES/BUILD STEP ***
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- Highly recommended for prompt/model selection UI
      "zbirenbaum/copilot.lua",        -- Core Copilot plugin
    },
    build = "make tiktoken", -- Required for token counting on Linux/macOS
    -- **********************************************************

    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        question_header = "  " .. user .. " ",
        answer_header = "  Copilot ",
        window = {
          width = 0.4,
          layout = 'float', -- Ensure a default layout is set
        },
      }
    end,

    keys = {
      { "<C-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          -- Use vim.ui.input directly as it handles the sync/async nature
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
    },

    -- FIX: This minimal config block ONLY contains the autocmd.
    -- lazy.nvim will automatically call require("CopilotChat").setup(opts) for you.
    config = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })
      -- The manual lines 'local chat = require("CopilotChat")' and 'chat.setup(opts)' MUST be removed.
    end,
  },
}
