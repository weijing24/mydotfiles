"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=" "
let g:mapleader = ' '

" Set to auto read when a file is changed
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

" 关闭方向键, 强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" encode settings
" ---------------------------------------------------------------------------------------------
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
" for macvim
if has("gui_macvim")
  set guifont=Anonymous\ Pro:h16
  set linespace=2   " set the line height

  " Options for Graphic version of VIM
  set guioptions-=T "No Toolbar
  set guioptions-=L "No left hand scrollbars
  set guioptions-=r "No right hand scrollbars
  set guioptions-=m "No menu bar

  " Don't beep
  set visualbell
  set lines=40 columns=130
  " set guifont=Menlo\ Bold:h18
  set guifont=Hack\ Nerd\ Font:h18\Bold
endif


" hightlight settings
" ---------------------------------------------------------------------------------------------
set cursorline 		"  高亮当前行
"highlight CursorLine   cterm=NONE ctermbg=darkred ctermfg=green guibg=NONE guifg=NONE
syntax on		" 进行语法检验，颜色显示
set hlsearch		" 不要高亮被搜索的句子
set incsearch		" search as characters are entered
set showmatch		" highlight matching [{()}]

set clipboard+=unnamed

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" install plugins
if filereadable(expand("~/.plug.vim"))
    source ~/.plug.vim
endif

" use plug settings
if filereadable(expand("~/.plugins_config.vim"))
    source ~/.plugins_config.vim
endif
