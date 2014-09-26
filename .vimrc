call plug#begin('~/.vim/plugged')

" Plugins
Plug 'kchmck/vim-coffee-script'
Plug 'slim-template/vim-slim'
Plug 'pangloss/vim-javascript'
Plug 'briancollins/vim-jst'
Plug 'avakhov/vim-yaml'
Plug 'greyblake/vim-preview'
Plug 'bling/vim-airline'
Plug 'Raimondi/delimitMate'
Plug 'hail2u/vim-css3-syntax'
" Plug 'Shougo/unite.vim'
" Plug 'airblade/vim-gitgutter'

Plug 'scrooloose/syntastic'
"
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'activebridge/rails-snippets'
Plug 'p0deje/vim-ruby-interpolation'
" Plug 'svermeulen/vim-easyclip'

Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

Plug 'vtreeexplorer'
Plug 'grep.vim'
Plug 'VIM-Color-Picker'
Plug 'LargeFile'
Plug 'L9'
Plug 'FuzzyFinder'
Plug 'Toggle'
Plug 'surround.vim'
Plug 'yaml.vim'
Plug 'rainbow-end'

call plug#end()

" Vim
colo railscasts                   " Theme
set expandtab ts=2 sw=2 ai        " Two spaces insted tab
set showtabline=2                 " Always shows tabs on top
set backspace=indent,eol,start    " Intuitive backspacing.
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set scrolloff=10                  " Show 3 lines of context around the cursor.
set visualbell                    " No beeping.
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile                    " Disable swp files
set shortmess=filmnrxtTI          " Disble intro message
set nohidden                      " Remove the buffer after tab close
set novisualbell
set list
set listchars=trail:•             " Show spaces in end of line
set autoread                      " Update open files when changed externally
set relativenumber                " Set relative line numbers
set laststatus=2
set re=1
set ttyfast
set lazyredraw
set nocursorcolumn
set nocursorline
syntax sync minlines=256
set synmaxcol=160
" set clipboard=unnamed
" set noballooneval
filetype plugin on                " Turn on file type detection.
filetype indent on                " Turn on file indent detection.

autocmd BufWritePre *.* :%s/\s\+$//e
" autocmd BufWritePre {*.rb,*.js,*.coffee,*.scss,*.haml,*.slim,*.erb,*.css,*.html,*.yml} :%s/\s\+$//e
map <C-s> :w<cr>
map <S-r> :%s/:\(\w\+\)\(\s*=>\s*\)/\1: /g<cr>
imap <C-s> <ESC>:w<cr>
map <C-a> <esc>ggVG<end>
vnoremap < <gv
vnoremap > >gv
cmap w!! %!sudo tee > /dev/null %
" autocmd! bufwritepost .vimrc nested source %
inoremap <c-x><c-]> <c-]>

" Bubble single&multiple lines
vnoremap <C-Up> <esc>`<gv:m '<-2<cr>gv
vnoremap <C-Down> <esc>`>gv:m '>+1<cr>gv
nnoremap <C-Up> mz:m-2<cr>`z
nnoremap <C-Down> mz:m+<cr>`z

" Tabs
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
nnoremap <C-e>     :q!<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>
inoremap <C-e>     <Esc>:q!<CR>i

"VSTreeExplorer
let treeExplVertical=1
let treeExplDirSort=1
let treeExplWinSize=40
command E VSTreeExplore

" Rgrep
map <C-f> :Rgrep<cr>
let Grep_Default_Filelist = '*.*'
let Grep_Skip_Files = '*.log *.sql *.png *.jpg *.jpeg *.gif'
let Grep_Skip_Dirs = '.git tmp system coverage log solr public _site'

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_enable_highlighting=0
" let g:syntastic_ruby_checkers = ['mri', 'rubocop']

" FuzzyFinder
let g:fuf_file_exclude = '\v\~$|\.(bak|swp|png|jpg|jpeg|log|sql|bmp|gif|svg|pdf)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|(^|[/\\])(_site|tmp|vendor)[/\\]|(^|[/\\])tmp[/\\]vendor[/\\]'
let g:fuf_coveragefile_exclude = '\v\~$|\.(bak|swp|png|jpg|jpeg|log|sql|bmp|gif|svg|pdf)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|(^|[/\\])(_site|tmp|vendor)[/\\]|(^|[/\\])tmp[/\\]vendor[/\\]'
let g:fuf_enumeratingLimit = 30
map <A-S-o> :FufCoverageFile<CR>
nnoremap <silent> <S-tab> :FufBuffer<CR>
map <F5> :FufRenewCache<cr>

" Commentary
map <C-c> <esc>gcc<end>
map <C-x> <esc>gcu<end>
vmap <C-c> gc

" Rails
map gV :Rview<CR>
map gC :Rcontroller<CR>
map gM :Rmodel<CR>
map gH :Rhelper<CR>
map gJ :Rjavascript<CR>
map gS :Rstylesheet<CR>

" to start vim maximized
function Maximize_Window()
  silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction
au GUIEnter * call Maximize_Window()

if exists("+undofile")
    set udf
    set undodir=~/.vim/undo
endif
