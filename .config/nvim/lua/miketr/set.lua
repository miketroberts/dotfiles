vim.cmd("filetype plugin indent on")
vim.opt.wrap = false
vim.opt.textwidth = 0 --  no line length

vim.opt.hlsearch = true --  highlight search results
vim.opt.incsearch = true --  match search results as we type
vim.opt.ignorecase = true --  ignore case when searching
vim.opt.smartcase = true --  match case if all lower case

vim.opt.showmatch = true --  show matching brackets
vim.opt.hidden = true --  allow changes to hidden buffers

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2 --  number of spaces for auto indent
vim.opt.smarttab = true
vim.opt.expandtab = true --  Get rid of tabs
vim.opt.softtabstop = 2 --  what distance should a tab *feel* like
vim.opt.autoindent = true --  always auto indent

vim.opt.backup = false --  do not create backup files EVER
vim.opt.swapfile = false --  do not create swap files EVER

vim.opt.scrolloff = 3 --  Start scrolling when 3 lines from the end of the buffer.
vim.opt.sidescroll = 5 --  Scroll horizontally 5 chars at a time.
vim.opt.sidescrolloff = 5 --  Start scrolling when 5 chars from edge of the window.

vim.opt.visualbell = false --  Turn off the visual bell.
vim.opt.errorbells = false --  Turn off error notification

vim.opt.foldmethod = marker --  Fold files on markers.

-- vim.opt.wildmenu=true                               --  Enable the wild menu
-- vim.opt.wildmode=list:longest,full                  --  Better completion
-- vim.opt.wildignore =.svn,CVS,.git                   --  Ignore VCS files
-- vim.opt.wildignore+=*.o,*.a,*.so                    --  Ignore compiled binaries
-- vim.opt.wildignore+=*.jpg,*.png,*.gif               --  Ignore images
-- vim.opt.wildignore+=*.pdf                           --  Ignore PDF files
-- vim.opt.wildignore+=*.pyc,*.pyo                     --  Ignore compiled Python files
-- vim.opt.wildignore+=*.hi,*.ho                       --  Ignore compiled Haskell files
-- vim.opt.wildignore+=*.fam                           --  Ignore compiled Falcon files
-- vim.opt.wildignore+=.*.class                        --  Ignore class files.
-- vim.opt.wildignore+=*build/*                        --  Ignore anything under the build directory.

vim.opt.matchpairs:append("<:>") --  Match angle brackets

vim.opt.laststatus = 2 --  Always have a status bar.
vim.opt.ruler = true --  If status bar is disabled, ensure we atleast have a ruler present

vim.opt.backspace = indent, eol, start --  Backspace can remove anything.

-- NeoVide Configuration
vim.g.neovide_fullscreen = false
vim.g.neovide_floating_blur_amount_x = 4.0
vim.g.floaterm_winblend = 15
vim.g.neovide_floating_blur_amount_y = 4.0
vim.g.neovide_remember_window_size = true
vim.g.neovide_transparency = 0.9
vim.g.neovide_padding_top = 10
vim.g.neovide_padding_bottom = 10
vim.g.neovide_padding_right = 10
vim.g.neovide_padding_left = 10
vim.g.neovide_cursor_animation_length = 0.03
vim.g.neovide_cursor_trail_length = 0.8
vim.g.neovide_cursor_vfx_mode = "railgun" -- Railgun particles behind cursor
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
vim.g.neovide_cursor_vfx_particle_density = 7.0
vim.g.neovide_cursor_vfx_particle_speed = 10.0
vim.g.neovide_cursor_vfx_particle_phase = 1.5
vim.g.neovide_cursor_vfx_particle_curl = 1.0
vim.g.neovide_cursor_unfocused_outline_width = 0.125
