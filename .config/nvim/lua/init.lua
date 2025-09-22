vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	change_detection = {
		-- Don't notify us every time a change is made to the configuration
		notify = false,
	},
	checker = {
		-- Automatically check for package updates
		enabled = true,
		-- Don't spam us with notification every time there is an update available
		notify = false,
	},
}

-- Load the options from the config/options.lua file
require("config.options")
-- Load the keymaps from the config/keymaps.lua file
require("config.keymaps")
-- Load the auto commands from the config/autocmds.lua file
require("config.autocmds")
-- Setup lazy, this should always be last
-- Tell lazy that all plugin specs are found in the plugins directory
-- Pass it the options we specified above
require("lazy").setup("plugins", opts)

-- require('lazy').setup({
--   -- NOTE: First, some plugins that don't require any configuration
--
--   -- Git related plugins
--   'tpope/vim-fugitive',
--   'tpope/vim-rhubarb',
--
--   -- Detect tabstop and shiftwidth automatically
--   'tpope/vim-sleuth',
--
--   -- NOTE: This is where your plugins related to LSP can be installed.
--   --  The configuration is done below. Search for lspconfig to find it below.
--   {
--     -- LSP Configuration & Plugins
--     'neovim/nvim-lspconfig',
--     dependencies = {
--       -- Automatically install LSPs to stdpath for neovim
--       'williamboman/mason.nvim',
--       'williamboman/mason-lspconfig.nvim',
--
--       -- Useful status updates for LSP
--       -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
--       { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
--
--       -- Additional lua configuration, makes nvim stuff amazing!
--       'folke/neodev.nvim',
--     },
--   },
--
--   {
--     -- Autocompletion
--     'hrsh7th/nvim-cmp',
--     dependencies = {
--       -- Snippet Engine & its associated nvim-cmp source
--       'L3MON4D3/LuaSnip',
--       'saadparwaiz1/cmp_luasnip',
--
--       -- Adds LSP completion capabilities
--       'hrsh7th/cmp-nvim-lsp',
--
--       -- Adds a number of user-friendly snippets
--       'rafamadriz/friendly-snippets',
--     },
--   },
--
--   -- Useful plugin to show you pending keybinds.
--   {
--     'folke/which-key.nvim',
--     event = "VeryLazy",
--     opts = {},
--     keys = {
--       {
--         "<leader>?",
--         function()
--           require("which-key").show({ global = false })
--         end,
--         desc = "Buffer Local Keymaps (which-key)",
--       },
--     },
--   },
--   {
--     'echasnovski/mini.nvim', version = false
--   },
--   {
--     -- Adds git related signs to the gutter, as well as utilities for managing changes
--     'lewis6991/gitsigns.nvim',
--     opts = {
--       -- See `:help gitsigns.txt`
--       signs = {
--         add = { text = '+' },
--         change = { text = '~' },
--         delete = { text = '_' },
--         topdelete = { text = '‾' },
--         changedelete = { text = '~' },
--       },
--       on_attach = function(bufnr)
--         vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
--
--         -- don't override the built-in and fugitive keymaps
--         local gs = package.loaded.gitsigns
--         vim.keymap.set({ 'n', 'v' }, ']c', function()
--           if vim.wo.diff then
--             return ']c'
--           end
--           vim.schedule(function()
--             gs.next_hunk()
--           end)
--           return '<Ignore>'
--         end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
--         vim.keymap.set({ 'n', 'v' }, '[c', function()
--           if vim.wo.diff then
--             return '[c'
--           end
--           vim.schedule(function()
--             gs.prev_hunk()
--           end)
--           return '<Ignore>'
--         end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
--       end,
--     },
--   },
--
--   -- {
--   --   -- Theme inspired by Atom
--   --   'navarasu/onedark.nvim',
--   --   priority = 1000,
--   --   config = function()
--   --     require('onedark').setup {
--   --       style = 'deep'
--   --     }
--   --     vim.cmd.colorscheme 'onedark'
--   --   end,
--   -- },
--   {
--     -- Theme inspired by Atom
--     'sainnhe/gruvbox-material',
--     priority = 1000,
--     config = function()
--       vim.cmd.colorscheme 'gruvbox-material'
--     end,
--   },
--   {
--     'EdenEast/nightfox.nvim',
--     priority = 1000
--   },
--   {
--     'catppuccin/nvim', name = 'catppuccin', priority = 1000
--   },
--   {
--     'Mofiqul/vscode.nvim', priority = 1000
--   },
--   -- {
--   --   "folke/tokyonight.nvim",
--   --   lazy = false,
--   --   priority = 1000,
--   --   opts = {},
--   --   config = function()
--   --     vim.cmd.colorscheme 'tokyonight-night'
--   --   end,
--   --
--   -- },
--   -- {
--   --   "catppuccin/nvim",
--   --   name = "catppuccin",
--   --   priority = 1000,
--   --   opts = {
--   --     flavour = "mocha", -- latte, frappe, macchiato, mocha
--   --     background = { -- :h background
--   --       light = "latte",
--   --       dark = "mocha",
--   --     },
--   --     transparent_background = false, -- disables setting the background color.
--   --     show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
--   --     term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
--   --     dim_inactive = {
--   --       enabled = false, -- dims the background color of inactive window
--   --       shade = "dark",
--   --       percentage = 0.15, -- percentage of the shade to apply to the inactive window
--   --     },
--   --     integrations = {
--   --       cmp = true,
--   --       gitsigns = true,
--   --       nvimtree = true,
--   --       treesitter = true,
--   --       notify = false,
--   --       mini = {
--   --         enabled = true,
--   --         indentscope_color = "",
--   --       },
--   --     },
--   --     color_overrides = {
--   --       mocha = { -- custom
--   --         rosewater = "#ffc6be",
--   --         flamingo = "#fb4934",
--   --         pink = "#ff75a0",
--   --         mauve = "#f2594b",
--   --         red = "#f2594b",
--   --         maroon = "#fe8019",
--   --         peach = "#FFAD7D",
--   --         yellow = "#e9b143",
--   --         green = "#b0b846",
--   --         teal = "#8bba7f",
--   --         sky = "#7daea3",
--   --         sapphire = "#689d6a",
--   --         blue = "#80aa9e",
--   --         lavender = "#e2cca9",
--   --         text = "#e2cca9",
--   --         subtext1 = "#e2cca9",
--   --         subtext0 = "#e2cca9",
--   --         overlay2 = "#8C7A58",
--   --         overlay1 = "#735F3F",
--   --         overlay0 = "#806234",
--   --         surface2 = "#665c54",
--   --         surface1 = "#3c3836",
--   --         surface0 = "#32302f",
--   --         base = "#282828",
--   --         mantle = "#1d2021",
--   --         crust = "#1b1b1b",
--   --
--   --       },
--   --     },
--   --   },
--   --   config = function()
--   --     vim.cmd.colorscheme 'catppuccin'
--   --   end,
--   --
--   -- },
--
--   -- {
--   --   "rebelot/kanagawa.nvim",
--   --   priority = 1000,
--   --   opts = {
--   --     undercurl = true,
--   --     commentStyle = {
--   --       italic = true
--   --     },
--   --     functionStyle = {},
--   --     keywordStyle = {
--   --       italic = true
--   --     },
--   --     statementStyle = {
--   --       italic = true
--   --     },
--   --     theme = "dragon"
--   --   },
--   --   config = function()
--   --     vim.cmd.colorscheme 'kanagawa-dragon'
--   --   end,
--   -- },
--
--   {
--     -- Set lualine as statusline
--     'nvim-lualine/lualine.nvim',
--     -- See `:help lualine.txt`
--     opts = {
--       options = {
--         icons_enabled = false,
--         theme = 'onedark',
--         component_separators = '|',
--         section_separators = '',
--       },
--     },
--   },
--
--   {
--     -- Add indentation guides even on blank lines
--     'lukas-reineke/indent-blankline.nvim',
--     -- Enable `lukas-reineke/indent-blankline.nvim`
--     -- See `:help ibl`
--     main = 'ibl',
--     opts = {},
--   },
--
--   -- "gc" to comment visual regions/lines
--   { 'numToStr/Comment.nvim', opts = {} },
--
--   -- Fuzzy Finder (files, lsp, etc)
--   {
--     'nvim-telescope/telescope.nvim',
--     branch = '0.1.x',
--     dependencies = {
--       'nvim-lua/plenary.nvim',
--       -- Fuzzy Finder Algorithm which requires local dependencies to be built.
--       -- Only load if `make` is available. Make sure you have the system
--       -- requirements installed.
--       {
--         'nvim-telescope/telescope-fzf-native.nvim',
--         -- NOTE: If you are having trouble with this installation,
--         --       refer to the README for telescope-fzf-native for more instructions.
--         build = 'make',
--         cond = function()
--           return vim.fn.executable 'make' == 1
--         end,
--       },
--     },
--   },
--
--   {
--     -- Highlight, edit, and navigate code
--     'nvim-treesitter/nvim-treesitter',
--     dependencies = {
--       'nvim-treesitter/nvim-treesitter-textobjects',
--     },
--     build = ':TSUpdate',
--   },
--   {
--     'nvim-tree/nvim-tree.lua',
--     dependencies = {
--       'nvim-tree/nvim-web-devicons'
--     },
--     opts = {
--       sort_by = "case_sensitive",
--       view = {
--         width = 30,
--       },
--       renderer = {
--         group_empty = true,
--       },
--       filters = {
--         dotfiles = true,
--       },
--     }
--   },
--   {
--     'Vigemus/iron.nvim',
--     opts = {
--       config = {
--         scratch_repl = true,
--         repl_definition = {
--           javascript = {
--             command = {"ts-node"}
--           }
--         },
--       },
--       highlight = {
--           italic = true
--       },
--       ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
--       keymaps = {
--         send_motion = "<leader>sc",
--         visual_send = "<leader>sc",
--         send_file = "<leader>sf",
--         send_line = "<leader>sl",
--         send_until_cursor = "<leader>su",
--         send_mark = "<leader>sm",
--         mark_motion = "<leader>mc",
--         mark_visual = "<leader>mc",
--         remove_mark = "<leader>md",
--         cr = "<leader>s<cr>",
--         exit = "<leader>sq",
--         clear = "<leader>cl",
--       },
--     },
--     keys = {
--       { "<leader>rs", "<cmd>IronRepl<cr>", desc = "Start repl" },
--       { "<leader>rr", "<cmd>IronRestart<cr>", desc = "Restart repl" },
--       { "<leader>rf", "<cmd>IronFocus<cr>", desc = "Focus repl" },
--       { "<leader>rh", "<cmd>IronHide<cr>", desc = "Hide repl" },
--     },
--     config = function(_, opts)
--       require("iron.core").setup(opts)
--     end,
--   },
--   {
--     "sourcegraph/sg.nvim",
--     dependencies = {
--       "nvim-lua/plenary.nvim",
--       "nvim-telescope/telescope.nvim"
--     },
--     opts = {
--       enable_cody = true,
--       accept_tos = true,
--       download_binaries = true
--     },
--     keys = {
--       { "<leader>ss", "<cmd>lua require('sg.extensions.telescope').fuzzy_search_results { input=vim.fn.expand('<cword>') }<CR>", desc = "SourceGraph Fuzzy Search" },
--     },
--   },
--   {
--     'akinsho/toggleterm.nvim',
--     version = "*",
--     config = true
--   },
--   -- {
--   --   'nvim-orgmode/orgmode',
--   --   dependencies = {
--   --     { 'ranjithshegde/orgWiki.nvim', lazy = true },
--   --     { 'nvim-treesitter/nvim-treesitter', lazy = true },
--   --   },
--   --   event = 'VeryLazy',
--   --   config = function()
--   --     -- Setup treesitter
--   --     require('nvim-treesitter.configs').setup({
--   --       highlight = {
--   --         enable = true,
--   --         additional_vim_regex_highlighting = { 'org' },
--   --       },
--   --       ensure_installed = { 'org' },
--   --     })
--   --
--   --     require('orgWiki').setup({
--   --       wiki_path = { '~/Documents/org/wiki' },
--   --       diary_path = '~/Documents/org/diary'
--   --     })
--   --
--   --     -- Setup orgmode
--   --     require('orgmode').setup({
--   --       org_agenda_files = '~/Documents/org/**/*',
--   --       org_default_notes_file = '~/Documents/org/refile.org',
--   --     })
--   --   end,
--   -- },
--   {
--     "will133/vim-dirdiff"
--   },
--   {
--     'rmagatti/auto-session',
--     config = function()
--     require("auto-session").setup {
--       log_level = "error",
--       auto_session_suppress_dirs = { "~/", "~/Documents", "/"},
--
--       auto_session_enable_last_session = false,
--
--       session_lens = {
--         -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
--         buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
--         load_on_setup = true,
--         theme_conf = { border = true },
--         previewer = false,
--       },
--     }
--     end
--   },
--   {
--     "vimwiki/vimwiki",
--     init = function()
--       vim.g.vimwiki_list = {
--         {
--           path = '~/Documents/vimwiki',
--           syntax = 'default',
--           ext = '.wiki',
--         },
--       }
--     end,
--   },
--   -- {
--   --   "jakobkhansen/journal.nvim",
--   --   config = function()
--   --     require("journal").setup(
--   --       {
--   --         filetype = 'md',                    -- Filetype to use for new journal entries
--   --         root = '~/Documents/journal',       -- Root directory for journal entries
--   --         date_format = '%Y/%m/%d',           -- Date format for `:Journal <date-modifier>`
--   --         autocomplete_date_modifier = "end", -- "always"|"never"|"end". Enable date modifier autocompletion
--   --         journal = {
--   --           -- Default configuration for `:Journal <date-modifier>`
--   --           format = '%Y/%m-%B/daily/%d-%A',
--   --           template = '# %A %B %d %Y\n',
--   --           frequency = { day = 1 },
--   --
--   --           -- Nested configurations for `:Journal <type> <type> ... <date-modifier>`
--   --           entries = {
--   --             day = {
--   --               format = '%Y/%m-%B/daily/%d-%A', -- Format of the journal entry in the filesystem.
--   --               template = '# %A %B %d %Y\n',    -- Optional. Template used when creating a new journal entry
--   --               frequency = { day = 1 },         -- Optional. The frequency of the journal entry. Used for `:Journal next`, `:Journal -2` etc
--   --             },
--   --             week = {
--   --               format = '%Y/%m-%B/weekly/week-%W',
--   --               template = "# Week %W %B %Y\n",
--   --               frequency = { day = 7 },
--   --               date_modifier = "monday" -- Optional. Date modifier applied before other modifier given to `:Journal`
--   --             },
--   --             month = {
--   --               format = '%Y/%m-%B/%B',
--   --               template = "# %B %Y\n",
--   --               frequency = { month = 1 }
--   --             },
--   --             year = {
--   --               format = '%Y/%Y',
--   --               template = "# %Y\n",
--   --               frequency = { year = 1 }
--   --             },
--   --           },
--   --         }
--   --       }
--   --     )
--   --   end,
--   -- },
--   {
--   },
--   {
--     'alexghergh/nvim-tmux-navigation',
--     config = function()
--     require'nvim-tmux-navigation'.setup {
--         disable_when_zoomed = true, -- defaults to false
--         keybindings = {
--             left = "<C-h>",
--             down = "<C-j>",
--             up = "<C-k>",
--             right = "<C-l>",
--             last_active = "<C-\\>",
--             next = "<C-Space>",
--         }
--     }
--     end
--   },
--   {
--     'willothy/wezterm.nvim',
--     config = true
--   },
--   {
--     'mrjones2014/smart-splits.nvim'
--   },
--   {
--     'ackeraa/todo.nvim',
--     config = function()
--       require("todo").setup {
--         opts = {
--           file_path = "/Users/miker/Documents/todo.txt"
--         }
--       }
--     end
--   }
--
--
--   -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
--   --       These are some example plugins that I've included in the kickstart repository.
--   --       Uncomment any of the lines below to enable them.
--   -- require 'kickstart.plugins.autoformat',
--   -- require 'kickstart.plugins.debug',
--
--   -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
--   --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
--   --    up-to-date with whatever is in the kickstart repo.
--   --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
--   --
--   --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
--   -- { import = 'custom.plugins' },
-- }, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  pickers = {
    find_files = {
      hidden = true
    }
  },
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'graphql', 'java' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Diagnostics
  nmap("gl", vim.diagnostic.open_float, "[O]pen [D]iagnostics")
  nmap("[d", vim.diagnostic.goto_prev, "[G]oto [P]revious Diagnostics")
  nmap("]d", vim.diagnostic.goto_next, "[G]oto [N]ext Diagnostics")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
-- require('which-key').register {
--   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
--   ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
--   ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
--   ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
--   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
--   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
--   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
-- }

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
-- require('mason').setup()
-- require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
-- local servers = {
--     -- clangd = {},
--     gopls = {},
--     graphql = {},
--     -- pyright = {},
--     -- rust_analyzer = {},
--     ts_ls = {},
--     -- html = { filetypes = { 'html', 'twig', 'hbs'} },
--
--     lua_ls = {
--         Lua = {
--             workspace = { checkThirdParty = false },
--             telemetry = { enable = false },
--         },
--     },
-- }
--

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
-- -- Ensure the servers above are installed
-- local mason_lspconfig = require 'mason-lspconfig'
--
-- mason_lspconfig.setup {
--   ensure_installed = vim.tbl_keys(servers),
-- }
--
-- mason_lspconfig.setup_handlers {
--   function(server_name)
--     require('lspconfig')[server_name].setup {
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = servers[server_name],
--       filetypes = (servers[server_name] or {}).filetypes,
--     }
--   end,
-- }

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
-- local cmp = require 'cmp'
-- local luasnip = require 'luasnip'
-- require('luasnip.loaders.from_vscode').lazy_load()
-- luasnip.config.setup {}
--
-- cmp.setup {
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body)
--     end,
--   },
--   mapping = cmp.mapping.preset.insert {
--     ['<C-n>'] = cmp.mapping.select_next_item(),
--     ['<C-p>'] = cmp.mapping.select_prev_item(),
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete {},
--     ['<CR>'] = cmp.mapping.confirm {
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = true,
--     },
--     ['<Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_locally_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--     ['<S-Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.locally_jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--   },
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' },
--   },
-- }

-- require('sg').setup({})
-- vim.keymap.set('n', '<leader>ss', function() require('sg.extensions.telescope').fuzzy_search_results({ input = vim.fn.expand('<cword>') }) end, { desc = '[S]earch by [S]ourceGraph Fuzzy Search' })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et


-- require'telescope'.load_extension('project')
--
-- require'telescope'.setup {
--     defaults = {
--       winblend = 1
--     },
-- 	extensions = {
-- 		base_dirs = {
-- 			'~/src/HCAHPS'
-- 		},
-- 		hidden_files = true
-- 	}
-- }

if vim.g.neovide then
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_remember_window_size = false
    vim.g.neovide_cursor_animation_length = 0.00
    vim.g.neovide_scroll_animation_length = 0.00
    vim.g.neovide_cursor_vfx_mode = "ripple"
    vim.g.neovide_cursor_smooth_blink = true
    vim.opt.guicursor = {
        "n-v-c:block-Cursor/lCursor",         -- Block cursor in normal, visual, and command modes
        "i:ver25-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",  -- Blinking vertical line in insert mode
        "r-cr-o:hor20-Cursor/lCursor",        -- Horizontal line cursor in replace, command-line replace, and operator-pending modes
        "a:blinkwait700-blinkoff400-blinkon250",  -- Global blinking settings for all modes
    }
    -- vim.o.guifont = "LiterationMono Nerd Font:h13"
    vim.o.guifont = "Input:h14"
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 0
    vim.g.linespace = 1.4
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_text_gamma=0.0


    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1/1.25)
    end)
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

