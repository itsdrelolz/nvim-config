


local cmp = require('cmp')

cmp.setup({
    mapping = {
        ['<C-Enter>'] = cmp.mapping.confirm({ select = true }),
    }
})


vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) 
vim.keymap.set("n", "<C-Enter>", "<cmd>lua require('cmp').mapping.confirm({select = true})<CR>")
