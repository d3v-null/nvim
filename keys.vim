"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TODO:
" - toggle relative line numbers
" - toggle paste
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Handy Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" open a new buffer containing all known key mappings
nnoremap \m :ShowMaps<CR>

" Quickly open a terminal emulator:
nnoremap <silent> <Leader><CR> :terminal<CR>a

" reload config 
nnoremap <leader>sv :source $MYVIMRC<CR>

" Fast saving
nmap <leader>w :w!<cr>

" insert & normal mode home and end
inoremap <C-A>		<Home>
inoremap <C-E>		<End>
nnoremap <C-A>		<Home>
nnoremap <C-E>		<End>

" TODO: Make scope of undo more granular
" These aren't working because they mess with deoplete
" imap <CR> <C-G>u<CR>
" imap <up> <C-G>u<up>
" imap <down> <C-G>u<down>
" inoremap <C-m> <C-G>u<C-m>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffers 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DOESN'T WORK ON NETRW :/
" deletes buffer but keeps window splits in tact
map <C-k> :Bclose<cr>
" requires BufDelete
" map <C-k> :BD<cr> 

" navigate buffers
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" default mapping is a duplicate, <c-b> & <c-f> ~= <c-u> & <c-d>
" so <c-f> for find files and <c-b> for find buffers
let g:ctrlp_map = '<c-f>'
map <c-b> :CtrlPBuffer<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>se :Errors<cr>
map <leader>sm :SyntasticToggleMode<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Unused & Duplicate keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" \
" <c-k>
" <c-s>
" <c-l>
" <c-q> = <c-v>
" <c-j> = <c-m> = ^N

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open a new buffer containing all known key mappings
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

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bwipeout! ".l:currentBufNum)
   endif
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    if a:extra_filter || a:firstline || a:lastline
        " unused arguments
    endif
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
