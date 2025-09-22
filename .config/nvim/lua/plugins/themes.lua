return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "macchiato", -- latte, frappe, macchiato, mocha
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
			-- vim.cmd.colorscheme 'catppuccin'
		end,
	},
	{
		"nuvic/flexoki-nvim",
		name = "flexoki",
		opts = {},
		config = function()
			-- vim.cmd.colorscheme 'flexoki'
		end,
	},
	{
		"zenbones-theme/zenbones.nvim",
		-- Optionally install Lush. Allows for more configuration or extending the colorscheme
		-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
		-- In Vim, compat mode is turned on as Lush only works in Neovim.
		dependencies = "rktjmp/lush.nvim",
		lazy = false,
		priority = 1000,
		-- you can set set configuration options here
		config = function()
			-- vim.g.zenbones_darken_comments = 45
			-- vim.cmd.colorscheme('zenwritten')
		end,
	},
	{
		"arzg/vim-colors-xcode",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd.colorscheme('xcodedarkhc')
		end,
	},
	{
		"vinitkumar/oscura-vim",
		lazy = false, -- Load during startup
	},
	{
		"sainnhe/gruvbox-material",
		lazy = false,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night", -- storm, day, night, moon
			transparent = true,
			terminal_colors = true,
			styles = {
				sidebars = "transparent", -- style for sidebars, see :h tokyonight-styles
				floats = "transparent", -- style for floating windows
			},
			on_highlights = function(hl, c)
				hl.CursorLineNr.fg = c.purple
			end,
		},
		config = function()
			-- vim.cmd.colorscheme('tokyonight')
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		config = function()
			-- vim.cmd.colorscheme('vscode')
		end,
	},
	{
		"loctvl842/monokai-pro.nvim",
		config = function()
			require("monokai-pro").setup({
				transparent_background = false,
				terminal_colors = true,
				devicons = true, -- highlight the icons of `nvim-web-devicons`
				styles = {
					comment = { italic = true },
					keyword = { italic = true }, -- any other keyword
					type = { italic = true }, -- (preferred) int, long, char, etc
					storageclass = { italic = true }, -- static, register, volatile, etc
					structure = { italic = true }, -- struct, union, enum, etc
					parameter = { italic = true }, -- parameter pass in function
					annotation = { italic = true },
					tag_attribute = { italic = true }, -- attribute of tag in reactjs
				},
				filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
				-- Enable this will disable filter option
				day_night = {
					enable = false, -- turn off by default
					day_filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
					night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
				},
				inc_search = "background", -- underline | background
				background_clear = {
					-- "float_win",
					"toggleterm",
					"telescope",
					-- "which-key",
					"renamer",
					"notify",
					-- "nvim-tree",
					-- "neo-tree",
					-- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
				}, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
				plugins = {
					bufferline = {
						underline_selected = false,
						underline_visible = false,
					},
					indent_blankline = {
						context_highlight = "default", -- default | pro
						context_start_underline = false,
					},
				},
			})
			-- vim.cmd.colorscheme("monokai-pro-octagon")
		end,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		name = "oxocarbon",
		opts = {},
		config = function()
			-- vim.cmd.colorscheme("oxocarbon")
		end,
	},
	{
		"vague2k/vague.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other plugins
		config = function()
			-- NOTE: you do not need to call setup if you don't want to.
			require("vague").setup({
				-- optional configuration here
			})
			vim.cmd("colorscheme vague")
		end,
	},
}
