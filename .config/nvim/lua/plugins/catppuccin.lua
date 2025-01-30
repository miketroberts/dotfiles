return {

    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
            light = "latte",
            dark = "mocha",
        },
        transparent_background = false, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
            enabled = false, -- dims the background color of inactive window
            shade = "dark",
            percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            notify = false,
            mini = {
                enabled = true,
                indentscope_color = "",
            },
        },
        color_overrides = {
            mocha = { -- custom
                rosewater = "#ffc6be",
                flamingo = "#fb4934",
                pink = "#ff75a0",
                mauve = "#f2594b",
                red = "#f2594b",
                maroon = "#fe8019",
                peach = "#FFAD7D",
                yellow = "#e9b143",
                green = "#b0b846",
                teal = "#8bba7f",
                sky = "#7daea3",
                sapphire = "#689d6a",
                blue = "#80aa9e",
                lavender = "#e2cca9",
                text = "#e2cca9",
                subtext1 = "#e2cca9",
                subtext0 = "#e2cca9",
                overlay2 = "#8C7A58",
                overlay1 = "#735F3F",
                overlay0 = "#806234",
                surface2 = "#665c54",
                surface1 = "#3c3836",
                surface0 = "#32302f",
                base = "#282828",
                mantle = "#1d2021",
                crust = "#1b1b1b",

            },
        },
    },
    config = function()
        vim.cmd.colorscheme 'catppuccin'
    end
}
