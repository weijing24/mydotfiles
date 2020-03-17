"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=" "

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set relativenumber 		" show relative line number
set number 		" show relative line number
set wildmenu			    " visual autocomplete for command menu
set wildignore=*.o,*~,*.pyc     " Ignore compiled files
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
set lazyredraw          " Don't redraw while executing macros
set noswapfile			" 停用 swap 文件
set nobackup			" 不需要备份文件
set nowritebackup		" 编辑的时候不需要备份文件
set noundofile			" 不创建撤销文件
set ignorecase			" 设置默认进行大小写不敏感查找
set smartcase			" 如果有一个大写字母，则切换到大小写敏感查找
set maxmempattern=2000000 	" 字符串匹配最大内存
set nocompatible		" 去除VI一致性
set noshowmode			" 不显示 INSERT
set expandtab              	" Use spaces instead of tabs.
set smarttab                " Be smart when using tabs
set tabstop=4
set shiftwidth=4
set lbr
set tw=500
" set autoindent			" 自动缩进
set si                      "Smart indent
set wrap                    "Wrap lines
set foldmethod=indent           " 代码折叠
set nofoldenable                " 不自动折叠
set backspace=indent,eol,start " for ycmi del
set whichwrap+=<,>,h,l
filetype plugin indent on 	" Load plugins according to detected filetype
" ts 一个TAB字符占多少个空格、sw 每层缩进的空格数、sts 每次退格将删除X个空格
autocmd FileType yaml setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType c,cpp,python,go setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4


" encode settings
" ---------------------------------------------------------------------------------------------
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

" hightlight settings
" ---------------------------------------------------------------------------------------------
set cursorline 		"  高亮当前行
"highlight CursorLine   cterm=NONE ctermbg=darkred ctermfg=green guibg=NONE guifg=NONE
syntax on		" 进行语法检验，颜色显示
set hlsearch		" 不要高亮被搜索的句子
set incsearch		" search as characters are entered
set showmatch		" highlight matching [{()}]

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" install plugins
if filereadable(expand("~/.vimrc.plug"))
    source ~/.vimrc.plug
endif

" Plug 'mhinz/vim-startify'                             " start page
" NERDTree config
" ---------------------------------------------------------------------------------------------
nnoremap <C-t> :NERDTreeToggle<CR>
" 打开vim时如果没有文件自动打开NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" 当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDChristmasTree=1
let NERDTreeShowLineNumbers=1
let g:NERDTreeChDirMode=2
let g:NERDTreeWinSize=30"  视窗大小
" let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" let NERDTreeShowBookmarks=1
" let g:NERDTreeMinimalUI=1

" startify config
" ---------------------------------------------------------------------------------------------
" autocmd VimEnter *
"             \   if !argc()
"             \ |   Startify
"             \ |   NERDTree
"             \ |   wincmd w
"             \ | endif

" lightline.vim config
" -------------------------------------------------------------------------------------------
colorscheme onehalfdark
set laststatus=2	" 显示状态行
let g:lightline = {
      \ 'colorscheme': 'onehalfdark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'mode': 'LightlineMode',
      \   'fugitive': 'LightlineFugitive',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'syntastic': 'SyntasticStatuslineFlag'
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

" vim-fugitive config
" -------------------------------------------------------------------------------------------
nnoremap <space>gs :Gstatus<cr>
nnoremap <space>gd :Gdiff<cr>
nnoremap <space>ga :Git add -p<cr>
nnoremap <space>gc :Gcommit -v<cr>

" vim-signify config
" -------------------------------------------------------------------------------------------
let g:signify_realtime=0
let g:signify_disable_by_default = 0
let g:signify_line_highlight = 1
let g:signify_vcs_list = ["git","svn"]
let g:signify_cursorhold_insert     = 1
let g:signify_cursorhold_normal     = 1
let g:signify_update_on_bufenter    = 0
let g:signify_update_on_focusgained = 1

" coc config

" auto-pairs config
au Filetype vim let b:AutoPairs= {'(':')', '[':']', '{':'}',"'":"'", '`':'`'}

" vim-commentary config
" ---------------------------------------------------------------------------------------------
autocmd FileType python,shell set commentstring=#\ %s                 " 设置Python,shell注释字符
autocmd FileType java,c,cpp set commentstring=//\ %s

" fzf config
" ---------------------------------------------------------------------------------------------
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

" vim-ack config
" ---------------------------------------------------------------------------------------------
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

" ale config
" ---------------------------------------------------------------------------------------------
" let g:ale_sign_column_always = 0                " 显示侧边栏
" let g:ale_lint_on_enter = 0                     " 打开文件时不进行检查
" let g:ale_lint_on_text_changed = 'never'        " 保存在检查
" let g:ale_lint_on_insert_leave = 0
" let g:ale_set_quickfix = 1                      " 打开quitfix对话框
" let g:ale_open_list = 1
" let g:ale_keep_list_window_open = 1
" let g:ale_list_window_size = 13
" let g:ale_set_highlights = 0
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format = '[%linter%] %code: %%s'
" let g:ale_linters = {
    " \ 'sh': ['language_server'],
    " \ }
" syntastic config
" ---------------------------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" vim auto save config
" ---------------------------------------------------------------------------------------------
let g:auto_save = 0
let g:auto_save_events = ["InsertLeave", "TextChanged", "TextChangedI", "CursorHoldI", "CompleteDone"]

" vim-go config
" ---------------------------------------------------------------------------------------------
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:godef_split=2
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
" autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>i <Plug>(go-info)

" vim-terraform config
" ---------------------------------------------------------------------------------------------
let g:terraform_align=1
let g:terraform_fold_sections=1
" let g:terraform_fmt_on_save=1

" syntastic config
" ---------------------------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" easymotion config
" ---------------------------------------------------------------------------------------------
" let g:EasyMotion_smartcase = 1
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
