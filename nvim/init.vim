"""SETUP ZSH
"""Copy script below
"sudo apt-get install ripgrep && sudo apt install zsh && sudo apt install powerline fonts-powerline && git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc && set zsh default chsh -s /bin/zsh
"change .zshrc like this https://github.com/kaiflife/dotfiles/blob/master/myzsh/.zshrc
""" nvim Plugins. Use :PlugInstall for install
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-sensible'
  Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'sheerun/vim-polyglot'
  Plug 'joshdick/onedark.vim'
  Plug 'dense-analysis/ale'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  Plug 'neoclide/coc.nvim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'jshint/jshint'
call plug#end()
""" autoimports for javascript :CocInstall coc-tsserver
""" ctrl+n to autocomplete
""" when coc give you a result just press ctrl+y for import module
""" to open images use m+o (open image using system image viewer)
"""Prettier use command :Prettier
""" Mappings
let g:ale_completion_autoimport = 1
let mapleader=" "
let g:ale_fixers['javascript'] = ['eslint']
let g:ale_sign_error = '?'
let g:ale_sign_warning = '??'
let g:ale_completion_enabled = 1
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "?",
    \ "Staged"    : "?",
    \ "Untracked" : "?",
    \ "Renamed"   : "?",
    \ "Unmerged"  : "?",
    \ "Deleted"   : "",
    \ "Dirty"     : "?",
    \ "Clean"     : "??",
    \ 'Ignored'   : '?',
    \ "Unknown"   : "?"
    \ 
}
"""FZF
map <leader>f <Esc>:GitFiles<CR>
map <leader>F <Esc>:Files<CR>
map <leader>L <Esc>:Rg<CR>
map <leader>l <Esc>:BLines<CR>
map <space> vaw

"shift + #, shift + * fast search in file

"for tsserver npm install -g neovim
":UpdateRemotePlugins

"If you want to chain commands from the vimrc file, then you need to use <bar> instead of | like this:
"<CR> - Enter
"ctrl + t open in new tab
nnoremap <silent><leader>o :FZF -q <C-R>=expand("<cword>")<CR><CR> 

""" Comments Mappings
map <leader>c <ESC> :Commentary<CR>
vmap <leader>c gc
""" Dublicate line mapping
nmap <C-d> mzyyp`z
nnoremap <MiddleMouse> :tabclose<CR> 
""" Tabs Mappings
map <leader>t <Esc>:tabnew<CR>
map <leader>w <Esc>:tabclose<CR>
map <leader>W <Esc>:tabclose!<CR>
map <leader>1 <Esc>1gt
map <leader>2 <Esc>2gt
map <leader>3 <Esc>3gt
map <leader>4 <Esc>4gt
map <leader>5 <Esc>5gt
map <leader>6 <Esc>6gt
map <leader>7 <Esc>7gt
map <leader>8 <Esc>8gt
map <leader>9 <Esc>9gt
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%:hidden', '?'),
  \   <bang>0)
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
""" Hide statusline
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd BufWinEnter * NERDTreeMirror

""" Common
syntax on
syntax enable
colorscheme onedark
set encoding=UTF-8
set mouse=a
set termguicolors
set background=dark
set clipboard=unnamedplus
set noswapfile
set updatetime=300
set shell=zsh
" Indentation
set wrap
set textwidth=79
set tabstop=2
set expandtab
set shiftwidth=2
set autoindent
set smartindent
filetype on
filetype plugin on
filetype indent on
set autoread
au FocusGained * :checktime
set number relativenumber
set omnifunc=ale#completion#OmniFunc
if exists('&colorcolumn')
  set colorcolumn=80
endif
hi Search guibg=guibg guifg=guifg gui=italic,underline,bold
