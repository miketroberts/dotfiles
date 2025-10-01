return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup({
			ui = {
				border = "rounded",
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"jdtls",
				"java-test",
				"java-debug-adapter",
			},
		})
	end,
}
