" Config for plugins & Themes

" Command to update plugins & vim-plug:
command! PU PlugUpdate | PlugUpgrade


call plug#begin()

Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'
Plug 'mgee/lightline-bufferline'
Plug 'ctrlpvim/ctrlp.vim'

" Theme
Plug 'joshdick/onedark.vim'


call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme onedark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NetRW
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" when browsing, <cr> will open the file by vertically splitting window first
" However this messes with P as well so ignore
" let g:netrw_browse_split = 3
" Sort by directories first, then files, other more complex sorting is
" disabled
let g:netrw_sort_sequence = '[\/]$,*,'
" Disable the banner which doesn't show anything useful anyway
let g:netrw_banner = 0
" specify initial size of new windows
let g:netrw_winsize = -25
" comma separated pattern list for hiding files
let g:netrw_list_hide = g:netrw_gitignore#Hide().'.*\.swp$'
" don't show hidden files (press a to toggle)
let g:netrw_hide = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }
let g:lightline.separator = { 'left': "", 'right': "" }
let g:lightline.subseparator = { 'left': "", 'right': "" }
let g:lightline.active = {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ],
      \             ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ }
let g:lightline.tabline = {'left': [['tabs', 'buffers']], 'right': [['close']]}
" let g:lightline.tab = {'active': ['tabnum'], 'inactive': ['tabnum']}
let g:lightline.component_function = {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ }
let g:lightline.component_expand = {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \   'buffers': 'lightline#bufferline#buffers' 
      \ }
let g:lightline.component_type = {
      \   'syntastic': 'error',
      \   'buffers': 'tabsel'
      \ }

function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return "-"
  else
    return ""
  endif
endfunction

function! LightlineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ' '  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFilename()
  return expand('%:t') !=# '' ? expand('%:f') : '[No Name]'
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

" augroup AutoSyntastic
"   autocmd!
"   autocmd BufWritePost *.c,*.cpp call s:syntastic()
" augroup END
 function! s:syntastic()
   SyntasticCheck
   call lightline#update()
 endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
let g:syntastic_force_overwrite_statusline = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Bufferline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" used to make bufferline display correctly in lightline
set showtabline=2
let g:bufferline_echo = 0
let g:bufferline_modified = ' +'
let g:bufferline_show_bufnr = 0
let g:bufferline_separator = ' '
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

