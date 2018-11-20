""""""""""""""""""""""""""""""
" => Python
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd FileType python setlocal cindent
    autocmd FileType python setlocal cinkeys-=0#
    autocmd FileType python setlocal indentkeys-=0#
endif

""""""""""""""""""""""""""""""
" => JavaScript
""""""""""""""""""""""""""""""

if has("autocmd")
    autocmd FileType javascript setlocal nocindent
    autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 noexpandtab
endif

""""""""""""""""""""""""""""""
" => Ruby
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
endif

""""""""""""""""""""""""""""""
" => Clojure
""""""""""""""""""""""""""""""
" if has("autocmd")
"     autocmd Filetype clojure setlocal 
" endif

