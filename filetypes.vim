""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd FileType python setlocal cindent
    autocmd FileType python setlocal cinkeys-=0#
    autocmd FileType python setlocal indentkeys-=0#
endif

""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""

if has("autocmd")
    autocmd FileType javascript setlocal nocindent
    autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 noexpandtab
endif

""""""""""""""""""""""""""""""
" => Ruby section
"""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
endif
