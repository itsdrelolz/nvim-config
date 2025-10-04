-- ~/.config/nvim/lua/plugins/copilot_chat.lua

return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary", -- Copilot Chat is often on the 'canary' branch for the latest features
  dependencies = {
    -- Required dependency
    "nvim-lua/plenary.nvim",
    -- Optional, but highly recommended for better UI/workflows
    "nvim-telescope/telescope.nvim",
    -- The core Copilot functionality plugin (which you already installed)
    "zbirenbaum/copilot.lua",
  },
  build = "make tiktoken", -- Required for token counting on Linux/macOS
  cmd = "CopilotChat",
  event = "VeryLazy",
  opts = function()
    local user = vim.env.USER or "User"
    -- Capitalize the first letter of the username
    user = user:sub(1, 1):upper() .. user:sub(2)

    return {
      auto_insert_mode = true,
      question_header = "  " .. user .. " ",
      answer_header = "  Copilot ",
      window = {
        layout = 'float', -- Can be 'float', 'vertical', or 'horizontal'
        width = 0.4,
      },
    }
  end,
  -- Keymaps are essential for using chat quickly
  keys = {
    { "<leader>ca", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
    -- Example for asking a quick question about the current file (visual mode)
    { "<leader>cc", function() 
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          require("CopilotChat").ask(input)
        end
      end, mode = "n", desc = "Copilot Quick Chat" 
    },
    -- ... add more keymaps from the plugin's documentation as desired
  }
}
