return {
    {
        "folke/tokyonight.nvim",
        -- TokyoNight configuration remains the same
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
        name = "catppuccin",
        priority = 1000, -- Highest priority
        init = function()
            -- Set the colorscheme immediately
            vim.cmd.colorscheme "catppuccin"
        end,
        -- The config block is now optional, but good for custom settings
        config = function()
            require('catppuccin').setup({
                transparent_background = true,
                styles = {
                    comments = {"italic"},
                },
            })
        end
    },
}
