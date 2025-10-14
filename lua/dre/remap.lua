-- [[ KEYMAPS ]]

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- makeshift fix for diagnostic problems 
keymap("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show Diagnostics" })

keymap("n", "<leader>ca", vim.lsp.buf.code_action,{ desc =  "Code Action" } )
keymap("n", "<leader>rn", vim.lsp.buf.rename, {desc = "Rename" } )

keymap("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous Diagnostic" })

keymap("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next Diagnostic" })




