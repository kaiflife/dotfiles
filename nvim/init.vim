"""USEFULL COMMANDS
"SHIFT+3 --- select word under the cursor and search it
"/ --- type to search word
"SHIFT+% --- jump between braces
"U --- undo all, u --- undo 1 step
"CTRL+R --- redo ALL, CTRL+r --- redo 1 step
"Press Ctrl-O to jump back to the previous (older) location.
"Press Ctrl-I (same as Tab) to jump forward to the next (newer) location.

"""SETUP NVIM UBUNTU

"""INSTALL NVIM
"cd ~ && sudo apt-get update && sudo apt install neovim

"""INSTALL XCLIP
"sudo apt install xclip

"""INSTALL NODEJS
"sudo apt install nodejs && sudo apt install npm && sudo apt install yarn && sudo npm install -g neovim

"""INSTALL YARN
curl --compressed -o- -L https://yarnpkg.com/install.sh | bash

"""INSTALL GIT
"sudo apt install git

"""INSTALL PLUG NVIM
"sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

"""INSTALL AND SETUP ZSH
"sudo apt-get install ripgrep && sudo apt install zsh && sudo apt install powerline fonts-powerline && git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc && set zsh default chsh -s /bin/zsh && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && sudo apt install python2 && sudo python2 get-pip.py && pip install neovim
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
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'jshint/jshint'
  Plug 'Valloric/MatchTagAlways'
  Plug 'SirVer/ultisnips'
  Plug 'mlaursen/vim-react-snippets'
  Plug 'jiangmiao/auto-pairs'
call plug#end()
"""AFTER PLUGINS INSTALLATIONS
" autoimports for javascript :CocInstall coc-tsserver
" ctrl+n to autocomplete
" when coc give you a result just press ctrl+y for import module

" to open images use m+o (open image using system image viewer)

"Prettier use command :Prettier

""" Mappings
let g:ale_completion_autoimport = 1
let mapleader=" "
let g:ale_fixers = {}
let g:ale_fixers.javascript = ['eslint']
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_completion_enabled = 1
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}

let g:NERDTreeGitStatusIndicatorMapCustom= {
    \"Modified"  : "✹",
    \"Staged"    : "✚",
    \"Untracked" : "✭",
    \"Renamed"   : "➜",
    \"Unmerged"  : "═",
    \"Deleted"   : "",
    \"Dirty"     : "✗",
    \"Clean"     : "✔︎",
    \'Ignored'   : '☒',
    \"Unknown"   : "?",
    \}

"""FZF
map <leader>f :wa <bar> <Esc>:GitFiles<CR>
map <leader>F :wa <bar> <Esc>:Files<CR>
map <leader>L :wa <bar> <Esc>:Rg<CR>
map <leader>l :wa <bar> <Esc>:BLines<CR>

"If you want to chain commands from the vimrc file, then you need to use <bar> instead of | like this:
"<CR> - Enter
nnoremap <silent> <leader>o :wa <bar> <Esc>:FZF -q <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> <leader>O :wa <bar> <Esc>:Rg <C-R>=expand("<cword>")<CR><CR>

"""SETUP GREP METHOD
"MACOS brew install ripgrep
"UBUNTU sudo apt-get install ripgrep
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    " set grepformat=%f:%l:%c:%m
endif
"""RENAME WORD
map <leader>rw :call SubstituteInFile(expand("<cword>"))<CR>
function! GetSubstituteCommand(range, term)
  "g – “Global” option. Perform the replace on every occurrence of a line
  "gc – Ask for confirmation before making each replacement.
  return a:range . "s" . input(":s", "/\\<" . a:term . "\\>/" . a:term . "/gc\<C-f>F/F/l")
endfunction

function! SubstituteInFile(text)
    execute GetSubstituteCommand("%", a:text)
endfunction
"""RENAME WORD

"""MULTIPLY RENAME WORD
map <leader>mrw :call SubstituteInCodebase(expand("<cword>"))<CR>

function! QuickfixDo(command)
    let itemCount = len(getqflist())
    let itemNr = 1
    while itemNr <= itemCount
        exe "cc " . itemNr
        exe a:command
        let itemNr = itemNr + 1
    endwhile
endfunction

function! SubstituteInCodebase(text)
    let grepCommand = GetGrepCommand(a:text)
    let substituteCommand = GetSubstituteCommand("", a:text)
    execute grepCommand
    call QuickfixDo(substituteCommand . " | update")
endfunction

function! GetGrepCommand(term)
  return "grep " . input(":grep ", "-w '" . a:term . "'\<C-f>F'F'l")
endfunction
"""MULTIPLY RENAME WORD

""" Comments Mappings
map <leader>c <Esc>:Commentary<CR>
vmap <leader>c gc

""" Dublicate line mapping
nmap <C-d> mzyyp`z
nnoremap <MiddleMouse> :wa <bar> :tabclose<CR> 

""" Tabs Mappings
map <leader>t :wa <bar> <Esc>:tabnew<CR>

map <leader>w :wa <bar> <Esc>:tabclose<CR>
map <leader>W :wa <bar> <Esc>:tabclose!<CR>
map <leader>1 <Esc>1gt
map <leader>2 <Esc>2gt
map <leader>3 <Esc>3gt
map <leader>4 <Esc>4gt
map <leader>5 <Esc>5gt
map <leader>6 <Esc>6gt
map <leader>7 <Esc>7gt
map <leader>8 <Esc>8gt
map <leader>9 <Esc>9gt

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
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

""" AutoClose
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*jsx,*js'
let g:closetag_emptyTags_caseSensitive = 1

let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'
let g:jsx_ext_required=0

"""Hightlight pair tag
nnoremap <leader>% :MtaJumpToOtherTag<cr>
let g:mta_use_matchparen_group = 1
let g:mta_filetypes = {
    \'javascriptreact': 1,
    \'javascript': 1,
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
\}
highlight MatchTag ctermfg=black ctermbg=lightgreen guifg=black guibg=lightgreen
hi link jsxCloseString htmlTag

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
