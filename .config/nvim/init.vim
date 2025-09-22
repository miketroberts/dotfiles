lua require('init')

set nocompatible

filetype off

filetype on                                     " Enable filetype detection.
filetype plugin on                              " Enable filetype specific plugins.
filetype indent on                              " Enable filetype specific indentation rules.

    set nowrap                                      " don't wrap lines
    set textwidth=0                                 " no line length

    set hlsearch                                    " highlight search results
    set incsearch                                   " match search results as we type
    set ignorecase                                  " ignore case when searching
    set smartcase                                   " match case if all lower case

    set showmatch                                   " show matching brackets
    set hidden                                      " allow changes to hidden buffers

    set tabstop=2
    set shiftwidth=2                                " number of spaces for auto indent
    set smarttab
    set expandtab                                   " Get rid of tabs
    set softtabstop=2                               " what distance should a tab *feel* like
    set autoindent                                  " always auto indent

    set smarttab cinwords=if,elif,else,for,while,try,except,finally,def,class


    set nobackup                                    " do not create backup files EVER
    set noswapfile                                  " do not create swap files EVER

    set scrolloff=3                                 " Start scrolling when 3 lines from the end of the buffer.
    set sidescroll=5                                " Scroll horizontally 5 chars at a time.
    set sidescrolloff=5                             " Start scrolling when 5 chars from edge of the window.

    set novisualbell                                " Turn off the visual bell.
    set noerrorbells                                " Turn off error notification

    set foldmethod=marker                           " Fold files on markers.

    set wildmenu                                    " Enable the wild menu
    set wildmode=list:longest,full                  " Better completion
    set wildignore =.svn,CVS,.git                   " Ignore VCS files
    set wildignore+=*.o,*.a,*.so                    " Ignore compiled binaries
    set wildignore+=*.jpg,*.png,*.gif               " Ignore images
    set wildignore+=*.pdf                           " Ignore PDF files
    set wildignore+=*.pyc,*.pyo                     " Ignore compiled Python files
    set wildignore+=*.hi,*.ho                       " Ignore compiled Haskell files
    set wildignore+=*.fam                           " Ignore compiled Falcon files
    set wildignore+=.*.class                        " Ignore class files.
    set wildignore+=*build/*                        " Ignore anything under the build directory.

    set matchpairs+=<:>                             " Match angle brackets

    set laststatus=2                                " Always have a status bar.
    set ruler                                       " If status bar is disabled, ensure we atleast have a ruler present
                                                " Make it have the stuff I need.
"    set statusline=%t%m%r%h%w\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

    set backspace=indent,eol,start                  " Backspace can remove anything.

    set t_Co=256
    set t_ut=                                       " Clear the Background Color Erase, or tmux will bleed through.
                                                    " https://sunaku.github.io/vim-256color-bce.html

    syntax on                                       " Enable syntax highlighting.

    " Python settings.
    let python_highlight_all = 1

    set encoding=utf-8
    set fileencoding=utf-8
    set fileencodings=ucs-bom,utf8,prc
    set ffs=unix,dos

    set listchars=tab:»\ ,extends:>,precedes:<,trail:□
    "set listchars=tab:»\ ,eol:¬,extends:>,precedes:<,trail:□
    "set list                                       " Set this on a per FT basis
    set lazyredraw                                  " Required for airline.

"lua require('init')
"lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}
"lua require'telescope'.load_extension('project')
"lua require('init')

nnoremap <silent> <leader>fp <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>fb <cmd>Telescope buffers<cr>

