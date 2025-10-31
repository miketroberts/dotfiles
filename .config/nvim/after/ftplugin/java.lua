vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.java" },
	callback = function()
		local _, _ = pcall(vim.lsp.codelens.refresh)
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*.java" },
	callback = function()
		local _, _ = pcall(vim.lsp.codelens.refresh)
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		local bufnr = vim.api.nvim_get_current_buf()
		local client = vim.lsp.get_clients({ bufnr = bufnr, name = "jdtls" })[1]

		require("vim.lsp").on_attach(client, bufnr)
		local status_ok, jdtls_dap = pcall(require, "jdtls.dap")
		if status_ok then
			jdtls_dap.setup_dap_main_class_configs()
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.java" },
	callback = function()
		-- Check if there's an active JDTLS client attached to the buffer
		local bufnr = vim.api.nvim_get_current_buf()
		local client = vim.lsp.get_clients({ bufnr = bufnr, name = "jdtls" })[1]

		if not client then
			print("No client, bye!")
			return
		end

		-- Send the synchronous request to the LSP
		local res = vim.lsp.buf_request_sync(bufnr, "java/organizeImports", {
			textDocument = {
				uri = vim.uri_from_bufnr(bufnr),
			},
		}, 1000) -- 1000ms timeout

		if res and res[1] and res[1].result then
			local action_result = res[1].result
			if action_result.changes then
				vim.lsp.util.apply_workspace_edit(action_result, "utf-8")
			end
		end
	end,
})
