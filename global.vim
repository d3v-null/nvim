"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Global config (shared between nvim and nvim gui) goes here
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 
" Show the filename in the window titlebar
set title
" Line numbers are good
set number
" show numbers relative to current line
set relativenumber
" Store lots of :cmdline history
set history=500
" Show the (partial) command as it’s being typed
set showcmd
" Enable mouse usage
set mouse=a
" Hide buffers in background
set hidden
" neosnippets conceal marker
set conceallevel=2 concealcursor=i
" Set up new vertical splits positions
set splitright
" Set up new horizontal splits positions
set splitbelow
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Don’t reset cursor to start of line when moving around.
set nostartofline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Backup / Swap / Undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Centralize backups, swapfiles and undo history
silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
set backupdir=~/.nvim/backups
set directory=~/.nvim/swaps
if exists("&undodir")
	set undodir=~/.nvim/undo
endif
" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set background to dark
set background=dark
" Colours show up properly in terminal
set termguicolors
" don't need showmode because of the lightline plugin
set noshowmode
" Set cursor blinking rate
set guicursor=a:blinkon500-blinkwait500-blinkoff500
" Highlight current line
set cursorline
" Highlight column 80
set colorcolumn=80
" Show “invisible” characters
set listchars=eol:¬,tab:▸\ ,trail:·,extends:»,precedes:«,nbsp:_
set list
" Syntax highlightning
syntax on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search / Replace options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set global flag for search and replace
set gdefault
" Smart case search if there is uppercase
set smartcase
" case insensitive search
set ignorecase
" Highlight matching bracket
set showmatch
" Allow recursive search of directories
set path+=**
"Show substitute changes immidiately at it is typed
set inccommand=nosplit
highlight Search cterm=underline gui=underline ctermbg=NONE guibg=NONE ctermfg=NONE guifg=NONE

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => whitespace options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Number of spaces to use for each step of (auto)indent. 
set shiftwidth=4
" Number of spaces that a <Tab> counts for while performing editing operations 
set softtabstop=4
" Number of spaces that a <Tab> in the file counts for.
set tabstop=4
" In Insert mode: Use the appropriate number of spaces to insert a <Tab>
set expandtab
" Every wrapped line will continue visually indented (same amount of space as the beginning of that line),
set breakindent
" Do smart autoindenting when starting a new line. 
set smartindent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Scrolling options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=8
" The minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set. 
set sidescrolloff=15

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Wildcard Completion options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion mode that is used for the character specified with 'wildchar'.
" list:full = When more than one match, list all matches and complete first match.
set wildmode=list:full
"stuff to ignore when tab completing
set wildignore=*.o,*.obj,*~                                                     
set wildignore+=*.git*
set wildignore+=*.meteor*
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*cache*
set wildignore+=*logs*
set wildignore+=*node_modules/**
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif