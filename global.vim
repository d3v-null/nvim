" Global config (shared between nvim and nvim gui) goes here

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
" Centralize backups, swapfiles and undo history
silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
set backupdir=~/.nvim/backups
set directory=~/.nvim/swaps
if exists("&undodir")
	set undodir=~/.nvim/undo
endif
" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Don’t reset cursor to start of line when moving around.
set nostartofline

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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Auto reload after config change
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>sv :source $MYVIMRC<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => showmaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:ShowMaps()
  let old_reg = getreg("a")          " save the current content of register a
  let old_reg_type = getregtype("a") " save the type of the register as well
try
  redir @a                           " redirect output to register a
  " Get the list of all key mappings silently, satisfy "Press ENTER to continue"
  silent map | call feedkeys("\<CR>")
  redir END                          " end output redirection
  vnew                               " new buffer in vertical window
  put a                              " put content of register
  " Sort on 4th character column which is the key(s)
  %!sort -k1.4,1.4
finally                              " Execute even if exception is raised
  call setreg("a", old_reg, old_reg_type) " restore register a
endtry
endfunction
com! ShowMaps call s:ShowMaps()      " Enable :ShowMaps to call the function

nnoremap \m :ShowMaps<CR>            " Map keys to call the function
