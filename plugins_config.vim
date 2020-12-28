"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-t> :NERDTreeToggle<CR>
" 打开vim时如果没有文件自动打开NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" 当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDChristmasTree       = 1
let NERDTreeShowLineNumbers = 1
let g:NERDTreeChDirMode     = 2
let g:NERDTreeWinSize       = 30  "  视窗大小
" let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" let NERDTreeShowBookmarks=1
" let g:NERDTreeMinimalUI=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => startify config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd VimEnter *
"             \   if !argc()
"             \ |   Startify
"             \ |   NERDTree
"             \ |   wincmd w
"             \ | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline.vim config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme onehalfdark
set laststatus=2	" 显示状态行
let g:lightline = {
      \ 'colorscheme': 'onehalfdark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'linter_warnings', 'linter_errors', 'linter_ok', 'lineinfo' ], ['percent'], [ 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'mode': 'LightlineMode',
      \   'fugitive': 'LightlineFugitive',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type': {
      \   'readonly': 'error',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'ok',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
\ }
function! LightlineMode()
    let fname = expand('%:t')
    return fname =~# 'NERD_tree' ? 'NERDTree' :
        \ &ft ==# 'unite' ? 'Unite' :
        \ &ft ==# 'vimfiler' ? 'VimFiler' :
        \ &ft ==# 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*FugitiveHead')
          let mark = ''  " edit here for cool mark
	      let branch = FugitiveHead()
	      return branch !=# '' ? mark.branch : ''
	    endif
    catch
    endtry
    return ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightlineFileencoding()
    return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline ale (syntax checker and linter)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" need to install fone awesome
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos    = "\uf129"
let g:lightline#ale#indicator_warnings = "\ue00a"
let g:lightline#ale#indicator_errors   = "\uf00d"
let g:lightline#ale#indicator_ok       = "\uf00c"


" vim-signify config
" -------------------------------------------------------------------------------------------
let g:signify_realtime              = 0
let g:signify_disable_by_default    = 0
let g:signify_line_highlight        = 1
let g:signify_vcs_list              = ["git","svn"]
let g:signify_cursorhold_insert     = 1
let g:signify_cursorhold_normal     = 1
let g:signify_update_on_bufenter    = 0
let g:signify_update_on_focusgained = 1

" auto-pairs config
au Filetype vim let b:AutoPairs= {'(':')', '[':']', '{':'}',"'":"'", '`':'`'}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-commentary config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType python,shell set commentstring=#\ %s                 " 设置Python,shell注释字符
autocmd FileType java,c,cpp set commentstring=//\ %s

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fzf config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_default_command='rg --files --no-ignore-vcs --hidden'
let g:fzf_layout = { 'right': '~60%' }
let g:fzf_commits_log_options='--graph --color=always
  \ --format="%C(yellow)%h%C(red)%d%C(reset)
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'
nnoremap <silent> <Leader><Space> :Files<CR>
nnoremap <silent> <Leader>h :History<CR>
nnoremap <silent> <Leader>gg :GFiles<CR>
nnoremap <silent> <Leader>gc :Commits<CR>
nnoremap <silent> <Leader>gr :Rg<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \                 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \                    <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \                            : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \                 <bang>0)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-ack config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('rg')
  " let g:ackprg = 'rg -S -H --nogroup --column'
  let g:ackprg = 'rg --vimgrep --no-heading'
endif
" let g:ack_autoclose = 1
" let g:ack_qhandler = "botright copen 15"
" let g:ack_use_cword_for_empty_search = 1
function Search(string) abort
  let saved_shellpipe = &shellpipe
  let &shellpipe = '>'
  try
    execute 'Ack!' shellescape(a:string, 1)
  finally
    let &shellpipe = saved_shellpipe
  endtry
endfunction
nnoremap <Leader>f :call Search("")<left><left>

" vim color scheme
nnoremap <silent> <Leader>C :call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'colo',
\   'options': '+m',
\   'left':    30
\ })<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ale (syntax checker and linter)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

" keep the sign gutter open
let g:ale_set_highlights = 0
" let g:ale_sign_column_always = 1

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'

let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
" use quickfix list instead of the loclist
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1
let g:ale_list_window_size = 8

let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'c++': ['cppcheck','clang', 'gcc'],
\   'c': ['cppcheck','clang', 'gcc'],
\   'bash': ['shellcheck'],
\   'python': ['pylint'],
\   'vim':  ['vint'],
\   'markdown': ['markdownlint']
\}


" syntastic config
" ---------------------------------------------------------------------------------------------
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" vim auto save config
" ---------------------------------------------------------------------------------------------
let g:auto_save = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "TextChangedI", "CursorHoldI", "CompleteDone"]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => easymotion config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:EasyMotion_smartcase = 1
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-slime config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:slime_target = "vimterminal"
let g:slime_vimterminal_cmd = "python3"
let g:slime_vimterminal_config = {"term_finish": "close"}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => editorconfig-vim config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let b:EditorConfig_disable = 0
au FileType gitcommit let b:EditorConfig_disable = 0
let g:EditorConfig_exclude_patterns = ['scp://.*']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => EasyAlign config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
