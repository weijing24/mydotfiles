" plugin to install
" ---------------------------------------------------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
" vim library
Plug 'ascenator/L9', {'name': 'newL9'}
" vim display
" Plug 'mhinz/vim-startify'                             " start page
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'                      " show git status
Plug 'sonph/onehalf', {'rtp': 'vim/'}			" vim theme
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'				" status theme
Plug 'maximbaz/lightline-ale'
" Plug 'mhinz/vim-startify'                             " start page
" git plugin
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-signify'                                " Show a diff replace gitgutter
Plug 'jreybert/vimagit'
" function
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'	" snips
Plug 'dense-analysis/ale'                          " 语法检查 replace scrooloose/syntastic
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'ycm-core/YouCompleteMe'
" Plug 'godlygeek/tabular'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'                             " 引号补全 replace Raimondi/delimitMate
Plug 'tpope/vim-commentary'                             " replace preservim/nerdcommenter
Plug 'tpope/vim-surround'				" 引号替换
Plug 'tpope/vim-repeat'                                 " 重复上一次操作
Plug 'sheerun/vim-polyglot'				" 语法高亮
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'	" 模糊搜索项目中的文件
Plug 'vim-scripts/vim-auto-save'
Plug 'bronson/vim-trailing-whitespace'
Plug 'mileszs/ack.vim'
" Plug for golang
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries'}
" Plug for terraform
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
call plug#end()
