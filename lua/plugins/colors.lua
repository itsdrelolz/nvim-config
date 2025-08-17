return {
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                style = "storm",
                transparent = true,
                terminal_colors = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                    sidebars = "dark",
                    floats = "dark",
                },
            })
        end
    },
    {
        "catppuccin/neovim",
        name = "catppuccin", -- Corrected name
        config = function()
            require('catppuccin').setup({
                transparent_background = true, -- Correct option
                styles = {
                    comments = {"italic"},
                },
            })
            vim.cmd("colorscheme catppuccin")
        end
    },
}
