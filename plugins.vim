scriptencoding utf-8
" Config for plugins & Themes

" Command to update plugins & vim-plug:
command! PU PlugUpdate | PlugUpgrade

" Plugins to be disabled
" Create empty list with names of disabled plugins if not defined
let g:plugs_disabled = get(g:, 'plug_disabled', [])

" Trim and extract repo name
" Same substitute/fnamemodify args as vim-plug itself
" https://github.com/junegunn/vim-plug/issues/469#issuecomment-226965736
function! s:plugs_disable(repo)
    let repo = substitute(a:repo, '[\/]\+$', '', '')
    let name = fnamemodify(repo, ':t:s?\.git$??')
    call add(g:plugs_disabled, name)
endfunction

" Append to list of repo names to be disabled just like they're added
" UnPlug 'junegunn/vim-plug'
command! -nargs=1 -bar UnPlug call s:plugs_disable(<args>)

call plug#begin()

" A pretty statusline, bufferline integration
Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'
" TODO: is this necessary
Plug 'mgee/lightline-bufferline'
" Fuzzy finder (files, mru, etc)
Plug 'ctrlpvim/ctrlp.vim'
" kill a buffer without closing window
Plug 'qpkorr/vim-bufkill'
" kill a buffer from ctrlp 
Plug 'd11wtq/ctrlp_bdelete.vim'

Plug 'prurigro/vim-polyglot-darkcloud'
" Plug 'sheerun/vim-polyglot'

" Disabled NCM2 because of backspace issue, replace with deoplete
" Plug 'ncm2/ncm2'
" ncm2 requires nvim-yarp
" Plug 'roxma/nvim-yarp'
" Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'
if has("nvim") 
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" Syntastic
Plug 'vim-syntastic/syntastic'

Plug 'sbdchd/neoformat'

" Universal commenting with toggle, motions, embedded syntax and more
Plug 'tomtom/tcomment_vim'

" Autoclose (, " etc
" Plug 'somini/vim-atoclose'
" Auto insert end statements
Plug 'tpope/vim-endwise'

" Use different paren management for clojure
Plug 'kovisoft/paredit'

" Handle surround chars like ''
Plug 'tpope/vim-surround'


" Select lines as text objects
Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-line'

" Easy tabular formatting
Plug 'godlygeek/tabular'

" Add 'diff' oprion when viewing swapfile
" Plug 'chrisbra/Recover.vim'
" Diff changes for swapfiles
Plug 'doy/vim-diff-changes'

" Parentheses are rainbow
" Plug 'kien/rainbow_parentheses.vim'
Plug 'luochen1990/rainbow'

" Language:Vim
" Vim linter
Plug 'syngan/vim-vimlint'
Plug 'ynkdir/vim-vimlparser'
" Vim completion
Plug 'Shougo/neco-vim'

" Language:Haskell
" GHC-mod integration
" Plug 'eagletmt/ghcmod-vim' | Plug 'Shougo/vimproc'
" Haskell completion
Plug 'eagletmt/neco-ghc'

" Language:Ruby
Plug 'vim-ruby/vim-ruby'

" Language:Markdown
" Plug 'plasticboy/vim-markdown'
" Plug 'gabrielelana/vim-markdown'

" Language: Python
Plug 'zchee/deoplete-jedi'

" Language: CSV
Plug 'chrisbra/csv.vim'

" Language: Clojure
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-classpath'
Plug 'guns/vim-clojure-highlight'

" Language: Arduino
Plug 'stevearc/vim-arduino'

" Theme:
Plug 'joshdick/onedark.vim'

" Remove disabled plugins from installation/initialization
" https://vi.stackexchange.com/q/13471/5070
call filter(g:plugs, 'index(g:plugs_disabled, v:key) == -1')

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
" specify initial size of new windows
" let g:netrw_winsize = -25
" Sort by directories first, then files, other more complex sorting is
" disabled
let g:netrw_sort_sequence = '[\/]$,*,'
" Disable the banner which doesn't show anything useful anyway
let g:netrw_banner = 0
" comma separated pattern list for hiding files
let g:netrw_list_hide = g:netrw_gitignore#Hide().'.*\.swp$'
" don't show hidden files (press a to toggle)
let g:netrw_hide = 1
" delete netrw when not focussed
autocmd FileType netrw setl bufhidden=wipe

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
  return expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
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
  if a:focus || a:byfname || a:marked  
  endif
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
    if a:str
        " unused variable
    endif
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    if a:current || a:sort
        " unused variable
    endif
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
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
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlP_bdelete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call ctrlp_bdelete#init()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NCM2 - Neovim Completion Manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd BufEnter * call ncm2#enable_for_buffer()
" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
" set shortmess+=c
" au TextChangedI * call(l ncm2#auto_trigger()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Deoplete - Completion 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic - Syntax Checker 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatic checking for active, only when :SyntasticCheck for passive
" https://github.com/timss/vimconf/issues/9
let g:syntastic_mode_map = get(g:, 'syntastic_mode_map', {
    \ 'mode': 'passive'})
let g:syntastic_mode_map.active_filetypes = [
    \ 'c', 'cpp', 'perl', 'python', 'vim', 'haskell', 'ruby']


" Skip check on :wq, :x, :ZZ etc
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_auto_loc_list = 1

augroup AutoSyntastic
    autocmd!
    execute "autocmd FileType " .
        \ join(g:syntastic_mode_map["active_filetypes"], ",") .
        \ " autocmd BufWritePost <buffer> :call lightline#update()"
augroup END

" hdevtools wouldn't work on my machine
let g:syntastic_haskell_checkers = ['hlint']
let g:syntastic_ruby_checkers = ['mri', 'rubocop']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neoformat - Code formatter 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neoformat_enabled_ruby = ['ruby-beautify', 'rubocop']

let g:neoformat_ruby_rubocop = {
    \ 'exe': 'rubocop',
    \ 'args': [
    \   '--auto-correct', 
    \   '--stdin', 
    \   '"%:p"',
    \	'2>/dev/null',
    \	'|',
    \	'sed "1,/^====================$/d"'
    \ ],
    \ 'replace' : 0,
    \ 'stdin': 1,
    \ 'no_append': 1,
    \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Language: Markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_conceal = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Language: Json
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fix vim-polyglot-darkcloud error when opening json
let g:vim_json_syntax_conceal=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parens
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:paredit_leader="<Space>"
