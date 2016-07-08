set nocompatible
filetype off

" set the runtime path to include Vundle and initialize it
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle.
Plugin 'VundleVim/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin indent on

syntax on

" colorscheme Tomorrow-Night
" ------------------------------------------------------------------
" Solarized Colorscheme Config
" ------------------------------------------------------------------
""let g:solarized_termtrans=1    "default value is 0
""let g:solarized_termcolors=256    "default value is 16
""syntax enable
set background=dark
colorscheme solarized
" ------------------------------------------------------------------

" disable bell/beep
set noerrorbells visualbell t_vb=


"" support for Go
""
au FileType go au BufWritePre <buffer> GoImports
au FileType go setlocal formatoptions=cqrot1 tw=80 ai nofoldenable

" insert mode completion
set completeopt=menu,longest

" size of a hard tabstop
set tabstop=4

" size of an "indent"
set shiftwidth=4

" maximum with of text that is being inserted.
set textwidth=80

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4

set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.
  
set incsearch       " While typing a search command,
					"  show immediately where the
                    " so far typed pattern matches.

set ignorecase      " Ignore case in search patterns.

set smartcase       " Override the 'ignorecase' option if the search pattern
					" contains upper case characters.

set ruler " Show the line and column number of the cursor position, separated by a comma.

"" line numbers
set number

set showcmd       " show the command we're typing
set showfulltag   " show full completion tags
set showmode      " show the mode all the time

set splitright
set splitbelow

set showmatch     " show matching bracket

set linebreak  "" wrap at 'breakat' instead of last char
set magic      "" enable 'magic'

set scrolloff=50  "" keep at least X lines above/below
set sidescroll=2
set sidescrolloff=5

set nospell

" always show statusline (useful for powerline)
set laststatus=2

" set nolist
" set listchars="tab:\ \ ,trail:•,extends:#,nbsp:."
" call clearmatches()

" menu-completion
set wildmode=longest,list,full
set wildmenu

" make sure we get the proper Ctrl+Left-arrow and +Right escape codes
set <C-Left>=Od
set <C-Right>=Oc

"" cycle thru buffers
:map <C-Right> :bnext<CR>
:map <C-Left> :bprevious<CR>

" remove trailing slash
nnoremap <silent> <F12> :retab <bar> %s/\s\+$//<CR>
