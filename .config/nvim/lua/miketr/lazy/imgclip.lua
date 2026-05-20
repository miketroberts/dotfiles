return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    -- add options here
    -- or leave it empty to use the default settings
  },
  keys = {
    -- suggested keymap
    { "<leader>ip", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    -- { "<leader>id", "<cmd>ImgClipDebug<cr>", dec = "Image clip debug." }
  },
  config = function()
    require("img-clip").setup({
      default = {
        prompt_for_file_name = false,
        filename = function()
          return os.date("%Y%m%d-%H%M%S") .. ".png"
        end,
      },
    })
  end
}
