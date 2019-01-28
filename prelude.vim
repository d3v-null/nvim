" Fetch vim-plug if it's not installed already:
if !filereadable(g:nvim_path . '/autoload/plug.vim')
  execute '!curl -fLo ' . g:nvim_path . '/autoload/plug.vim --create-dirs '
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" more accessible leader
let g:mapleader = " "