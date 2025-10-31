return {
	{
		"zbirenbaum/copilot.lua",
		dependencies = {
			"copilotlsp-nvim/copilot-lsp",
			"zbirenbaum/copilot-cmp",
		},
		config = function()
			require("copilot_cmp").setup()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
				logger = {
					file_log_level = vim.log.levels.TRACE,
				},
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			window = {
				layout = "float",
				width = 80, -- Fixed width in columns
				height = 20, -- Fixed height in rows
				border = "double", -- 'single', 'double', 'rounded', 'solid'
				title = "🤖 AI Assistant",
				zindex = 100, -- Ensure window stays on top
			},

			headers = {
				user = "👤 You",
				assistant = "🤖 Copilot",
				tool = "🔧 Tool",
			},

			separator = "━━",
			auto_fold = true, -- Automatically folds non-assistant messages
		},
	},
}
