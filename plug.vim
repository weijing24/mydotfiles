" plugin to install
" ---------------------------------------------------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" ---------------------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
" vim library
Plug 'ascenator/L9', {'name': 'newL9'}
" ---------------------------------------------------------------------------------------------
" vim display
                                      " Plug 'mhinz/vim-startify'                             " start page
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'    " show git status
Plug 'sonph/onehalf', {'rtp': 'vim/'} " vim theme
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'          " status theme
Plug 'maximbaz/lightline-ale'
" ---------------------------------------------------------------------------------------------
" git plugin
Plug 'mhinz/vim-signify'                                " Show a diff replace gitgutter
Plug 'jreybert/vimagit'
" ---------------------------------------------------------------------------------------------
" function
Plug 'jpalardy/vim-slime'                           " ctrl-c ctrl-c exec py script
Plug 'junegunn/vim-easy-align'                      " 文本对齐
Plug 'editorconfig/editorconfig-vim'                " code format
Plug 'dense-analysis/ale'                           " 语法检查 replace scrooloose/syntastic
Plug 'easymotion/vim-easymotion'                    " 快速移动
Plug 'jiangmiao/auto-pairs'                         " 引号补全 replace Raimondi/delimitMate
Plug 'tpope/vim-commentary'                         " 注释 replace preservim/nerdcommenter
Plug 'tpope/vim-surround'                           " 引号替换
Plug 'tpope/vim-repeat'                             " 重复上一次操作
Plug 'sheerun/vim-polyglot'                         " 语法高亮
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' " 模糊搜索项目中的文件
Plug 'vim-scripts/vim-auto-save'
Plug 'mileszs/ack.vim'
" ---------------------------------------------------------------------------------------------
call plug#end()
" ---------------------------------------------------------------------------------------------
