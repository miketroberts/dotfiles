return {
  "williamboman/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "jay-babu/mason-nvim-dap.nvim"
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
        "js-debug-adapter"
      },
    })
  end,
}
