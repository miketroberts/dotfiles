return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.5",

  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install'
    }
  },

  config = function()
    require('telescope').setup({
      extensions = {
        fzf = {
          fuzzy = true,                     -- false will only do exact matching
          override_generic_sorter = true,   -- override the generic sorter
          override_file_sorter = true,      -- override the file sorter
          case_mode = "smart_case",         -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        }
      }
    })

    require('telescope').load_extension('fzf')

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>fp', builtin.find_files, { desc = 'Search [F]ile [P]aths' })
    vim.keymap.set('n', '<leader>fs', builtin.git_files, { desc = 'Search [F]iles [S]ource Control' })
    vim.keymap.set('n', '<leader>fw', function()
      local word = vim.fn.expand('<cword>')
      builtin.grep_string({ search = word }, { desc = 'Search [F]iles for [w]ord under cursor' })
    end)
    vim.keymap.set('n', '<leader>fW', function()
      local word = vim.fn.expand('<cWORD>')
      builtin.grep_string({ search = word }, { desc = 'Search [F]iles for [W]ORDR under cursor' })
    end)
    vim.keymap.set('n', '<leader>fg', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") }, { desc = 'Search [F]iles with [G]rep' })
    end)
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Search [F]iles [Buffers]' })
  end
}
