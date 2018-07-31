" User's Neovim configuration path (e.g. ~/.config/nvim):
let g:nvim_path = split(&runtimepath, ',')[0]

" Fetch vim-plug if it's not installed already:
if !filereadable(g:nvim_path . '/autoload/plug.vim')
  execute '!curl -fLo ' . g:nvim_path . '/autoload/plug.vim --create-dirs '
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" more accessible leader
let g:mapleader = " "

" Load the rest of the configuration:
execute 'source ' . g:nvim_path . '/plugins.vim'
execute 'source ' . g:nvim_path . '/global.vim'
execute 'source ' . g:nvim_path . '/keys.vim'

" DONE:
" x Easy way to bufdelete netrw buffers
" x completion with Deoplete
" TODO:
" - auto update syntastic errors
" - numbered buffers in bufferline
" - surrounds
" - fix backspace issue and enable completion with NCM2
" TOINSTALL:
" Universal commenting with toggle, motions, embedded syntax and more
" Plug 'tomtom/tcomment_vim'
" Autoclose (, " etc
" Plug 'somini/vim-autoclose'
" UNIX shell command helpers, e.g. sudo, chmod, remove etc.
" Plug 'tpope/vim-eunuch'
" Git wrapper inside Vim
" Plug 'tpope/vim-fugitive'
" Handle surround chars like ''
" Plug 'tpope/vim-surround'
" Functions, class data etc.
" depends on either exuberant-ctags or universal-ctags
" if executable('ctags-exuberant') || executable('ctags')
"     Plug 'majutsushi/tagbar'
" endif
