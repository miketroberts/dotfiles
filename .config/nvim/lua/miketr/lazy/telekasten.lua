local home = vim.fn.expand("~/Documents/Notes")

return {
  {
    "renerocksai/telekasten.nvim",

    dependencies = {
      "nvim-telescope/telescope.nvim",
      "renerocksai/calendar-vim",
    },

    cmd = "Telekasten",

    keys = {
      { "<leader>np", "<cmd>Telekasten panel<cr>",               desc = "[N]otes [P]anel" },
      { "<leader>nf", "<cmd>Telekasten find_notes<cr>",          desc = "[N]otes [F]ind by title" },
      { "<leader>ng", "<cmd>Telekasten search_notes<cr>",        desc = "[N]otes [G]rep contents" },
      { "<leader>nn", "<cmd>Telekasten new_note<cr>",            desc = "[N]otes [N]ew" },
      { "<leader>nN", "<cmd>Telekasten new_templated_note<cr>",  desc = "[N]otes [N]ew from template" },
      { "<leader>nd", "<cmd>Telekasten goto_today<cr>",          desc = "[N]otes today's [D]aily" },
      { "<leader>nw", "<cmd>Telekasten goto_thisweek<cr>",       desc = "[N]otes this [W]eek" },
      { "<leader>nD", "<cmd>Telekasten find_daily_notes<cr>",    desc = "[N]otes find [D]ailies" },
      { "<leader>nW", "<cmd>Telekasten find_weekly_notes<cr>",   desc = "[N]otes find [W]eeklies" },
      { "<leader>nl", "<cmd>Telekasten follow_link<cr>",         desc = "[N]otes follow [L]ink" },
      { "<leader>nb", "<cmd>Telekasten show_backlinks<cr>",      desc = "[N]otes [B]acklinks" },
      { "<leader>nF", "<cmd>Telekasten find_friends<cr>",        desc = "[N]otes [F]riends (same link)" },
      { "<leader>nt", "<cmd>Telekasten show_tags<cr>",           desc = "[N]otes [T]ags" },
      { "<leader>nc", "<cmd>Telekasten show_calendar<cr>",       desc = "[N]otes [C]alendar" },
      { "<leader>nr", "<cmd>Telekasten rename_note<cr>",         desc = "[N]otes [R]ename" },
      { "<leader>ni", "<cmd>Telekasten insert_link<cr>",         desc = "[N]otes [I]nsert link" },
      { "<leader>ny", "<cmd>Telekasten yank_notelink<cr>",       desc = "[N]otes [Y]ank link to note" },
      { "<leader>nI", "<cmd>Telekasten insert_img_link<cr>",     desc = "[N]otes [I]nsert image link" },
      { "<leader>nP", "<cmd>Telekasten paste_img_and_link<cr>",  desc = "[N]otes [P]aste image" },
      { "<leader>nm", "<cmd>Telekasten browse_media<cr>",        desc = "[N]otes browse [M]edia" },
      { "<leader>nx", "<cmd>Telekasten toggle_todo<cr>",         desc = "[N]otes toggle todo", mode = { "n", "v" } },
    },

    -- `[[` only expands to the link picker inside the notes vault, so it stays
    -- out of the way when typing brackets in code.
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("telekasten_insert_link", { clear = true }),
        pattern = home .. "/*.md",
        callback = function(args)
          vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<cr>", {
            buffer = args.buf,
            desc = "Telekasten insert link",
          })
        end,
      })
    end,

    opts = {
      home = home,

      dailies = home .. "/daily",
      weeklies = home .. "/weekly",
      templates = home .. "/templates",
      image_subdir = home .. "/images",

      template_new_note = home .. "/templates/new_note.md",
      template_new_daily = home .. "/templates/daily.md",
      template_new_weekly = home .. "/templates/weekly.md",

      extension = ".md",

      -- Keep the buffer filetype as `markdown` so render-markdown.nvim,
      -- conform and the markdown treesitter parser all keep working.
      auto_set_filetype = false,
      auto_set_syntax = false,

      new_note_filename = "title",
      new_note_location = "smart",
      follow_creates_nonexisting = true,
      rename_update_links = true,

      image_link_style = "markdown",
      sort = "modified",
      tag_notation = "#tag",
      command_palette_theme = "ivy",
      show_tags_theme = "ivy",

      plug_into_calendar = true,
      calendar_opts = {
        weeknm = 1,
        calendar_monday = 1,
        calendar_mark = "left-fit",
      },

      clipboard_program = "osascript",
    },
  },
}
