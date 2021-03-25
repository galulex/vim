call plug#begin('~/.vim/plugged')

" Plugins

" Syntax
Plug 'kchmck/vim-coffee-script'
Plug 'slim-template/vim-slim'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'chase/vim-ansible-yaml'
Plug 'hail2u/vim-css3-syntax'
Plug 'othree/svg-properties-syntax.vim'
Plug 'othree/html5.vim'
Plug 'ap/vim-css-color'
Plug 'gcorne/vim-sass-lint'
Plug 'vim-scripts/indentpython.vim' " python
Plug 'KabbAmine/vCoolor.vim' " :VCoolor – colorpicer
Plug 'p0deje/vim-ruby-interpolation'
Plug 'vim-scripts/rainbow-end'
Plug 'w0rp/ale'
Plug 'rhysd/vim-crystal'

" Styles
Plug 'ryanoasis/vim-webdevicons'
Plug 'blueyed/vim-diminactive'
Plug 'mhinz/vim-startify' " Start screen

" Bottom line
Plug 'bling/vim-airline'
Plug 'ntpeters/vim-airline-colornum'

" Tools
Plug 'itchyny/calendar.vim' " :Calendar
Plug 'AndrewRadev/splitjoin.vim' " gS gJ single-line -> multi-line statemane
Plug 'Raimondi/delimitMate' " Closing quotes, brackets etc.
Plug 'activebridge/rails-snippets'
Plug 'honza/vim-snippets'
Plug 'terryma/vim-multiple-cursors' " Multiple selection <C-n>
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive' " Git :help Git
Plug 'vim-scripts/grep.vim' " <C-f>
Plug 'vim-scripts/EasyGrep'
Plug 'vim-scripts/Toggle' " <S-+> – true -> false, positive -> negative etc.
Plug 'vim-scripts/surround.vim' " Press cs"' (double quote -> single quote) inside
Plug 'ctrlpvim/ctrlp.vim'

" Other
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'vim-scripts/LargeFile'
Plug 'vim-scripts/L9'
Plug 'vim-scripts/vim-qf'

call plug#end()

" Vim
colo railscasts                   " Theme
set guifont=Monospace\ 12         " Font
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
" set iskeyword-=_                  " Underscore brakes the word
set laststatus=2
set re=1
set ttyfast
set lazyredraw
set nocursorcolumn
set nocursorline
syntax sync minlines=256
set synmaxcol=300
" set clipboard=unnamed
" set noballooneval
filetype plugin on                " Turn on file type detection.
filetype indent on                " Turn on file indent detection.
set tags=tmp/
set noballooneval
setlocal balloonexpr=
set balloondelay=100000

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
let g:webdevicons_enable_nerdtree = 0
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_tabline = 1

" Bubble single&multiple lines
vnoremap <C-Up> <esc>`<gv:m '<-2<cr>gv
vnoremap <C-Down> <esc>`>gv:m '>+1<cr>gv
nnoremap <C-Up> mz:m-2<cr>`z
nnoremap <C-Down> mz:m+<cr>`z

" Tabs
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-Up>    :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-Down>  :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
nnoremap <C-e>     :q!<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-Up>  <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-Down>  <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>
inoremap <C-e>     <Esc>:q!<CR>i


" ALE
let g:ale_fix_on_save = 1
let g:lint_on_insert_leave = 1
let g:lint_on_text_changed = 0
" let g:ale_sign_column_always=1

" Rgrep
map <C-f> :Rgrep<cr>
let Grep_Default_Filelist = '*.*'
let Grep_Skip_Files = '*.log *.sql *.png *.jpg *.jpeg *.gif'
let Grep_Skip_Dirs = '.git tmp system coverage log solr public _site node_modules'

let g:diminactive_use_colorcolumn = 0
let g:diminactive_use_syntax = 1

let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

" CtrlP
let g:ctrlp_map = '<A-o>' " Comment if you use OSX
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|tmp|coverage|log|node_modules|fixtures)$'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:10,results:10'

nnoremap <silent> <S-tab> :CtrlPBuffer<CR>

" Commentary
map <C-c> <esc>gcc<end>
map <C-x> <esc>gcu<end>
vmap <C-c> gc

" Rails
map gV :Eview<CR>
map gC :Econtroller<CR>
map gM :Emodel<CR>
map gH :Ehelper<CR>
map gJ :Ejavascript<CR>
map gS :Estylesheet<CR>

" to start vim maximized
function Maximize_Window()
  silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction
au GUIEnter * call Maximize_Window()

if exists("+undofile")
    set udf
    set undodir=~/.vim/undo
endif

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" Open current directory
map <S-w> :e %:h<CR>
" Copy line or visual zone to clipboard
map cp "+y<CR>
" Copy current file path to clipboard let @+=@%<CR>

" C Prerequirements
set exrc
set secure


" RU
map ё `
map й q
map ц w
map у e
map к r
map е t
map н y
map г u
map ш i
map щ o
map з p
map х [
map ъ ]
map ф a
map ы s
map в d
map а f
map п g
map р h
map о j
map л k
map д l
map ж ;
map э '
map я z
map ч x
map с c
map м v
map и b
map т n
map ь m
map б ,
map ю .
map . /

map Ё ~
map Й Q
map Ц W
map У E
map К R
map Е T
map Н Y
map Г U
map Ш I
map Щ O
map З P
map Х {
map Ъ }
map Ф A
map Ы S
map В D
map А F
map П G
map Р H
map О J
map Л K
map Д L
map Ж :
map Э "
map Я Z
map Ч X
map С C
map М V
map И B
map Т N
map Ь M
map Б <
map Ю >
map , ?

command! CopyBuffer let @+ = expand('%')
command! CopyBufferFull let @+ = expand('%:p')
