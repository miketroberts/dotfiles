return {
    {
        "garymjr/nvim-snippets",
        keys = {
            {
                "<Tab>",
                function()
                    if vim.snippet.active({ direction = 1 }) then
                        vim.schedule(function()
                            vim.snippet.jump(1)
                        end)
                        return
                    end
                    return "<Tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            {
                "<Tab>",
                function()
                    vim.schedule(function()
                        vim.snippet.jump(1)
                    end)
                end,
                expr = true,
                silent = true,
                mode = "s",
            },
            {
                "<S-Tab>",
                function()
                    if vim.snippet.active({ direction = -1 }) then
                        vim.schedule(function()
                            vim.snippet.jump(-1)
                        end)
                        return
                    end
                    return "<S-Tab>"
                end,
                expr = true,
                silent = true,
                mode = { "i", "s" },
            },
        },
    },
    {
	    "chrisgrieser/nvim-scissors",
	    dependencies = "nvim-telescope/telescope.nvim", -- if using telescope
	    opts = {
		    snippetDir = vim.fn.stdpath('config') .. '/snippets',
	    },
        keys = {
            {
                "<leader>se",
                function()
                    require("scissors").editSnippet()
                end,
                desc = "Snippet: Edit"
            },
            {
                "<leader>sa",
                function()
                    require("scissors").addNewSnippet()
                end,
                desc = "Snippet: Add",
                mode = { "n", "x" },
            }
        }
    }
}
