
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

nnoremap \m :ShowMaps<CR>            



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Handy Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Quickly open a terminal emulator:
nnoremap <silent> <Leader><CR> :terminal<CR>a

" reload config 
nnoremap <leader>sv :source $MYVIMRC<CR>

" Fast saving
nmap <leader>w :w!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => BufDelete 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deletes buffer but keeps window splits in tact
map <C-k> :BD<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" default mapping is a duplicate, <c-b> & <c-f> ~= <c-u> & <c-d>
" so <c-f> for find files and <c-b> for find buffers
let g:ctrlp_map = '<c-f>'
map <c-b> :CtrlPBuffer<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Unused & Duplicate keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" \
" <c-k>
" <c-s>
" <c-l>
" <c-q> = <c-v>
" <c-j> = <c-m> = ^N
" 
