return {
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
}
