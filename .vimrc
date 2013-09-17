filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Plugins
Bundle 'kchmck/vim-coffee-script'
Bundle 'slim-template/vim-slim'
Bundle 'pangloss/vim-javascript'
Bundle 'briancollins/vim-jst'
Bundle 'jiangmiao/auto-pairs'
Bundle 'avakhov/vim-yaml'
Bundle 'greyblake/vim-preview'
Bundle 'bling/vim-airline'

Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/snipmate-snippets'

Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-haml'

"Bundle 'tabpage.vim'
Bundle 'grep.vim'
Bundle 'VIM-Color-Picker'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'Toggle'
Bundle 'rubycomplete.vim'
Bundle 'surround.vim'
Bundle 'yaml.vim'

" Vim
colo railscasts                   " Theme
set number                        " Numers of lines
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
set noballooneval
filetype plugin on                " Turn on file type detection.
filetype indent on                " Turn on file indent detection.

autocmd BufWritePre *.* :%s/\s\+$//e
autocmd BufWritePre {*.rb,*.js,*.coffee,*.scss,*.haml,*.slim,*.erb} :%s/\s\+$//e
map <C-s> :w<cr>
map <S-r> :%s/:\(\w\+\)\(\s*=>\s*\)/\1: /g<cr>
imap <C-s> <ESC>:w<cr>
map <C-a> <esc>ggVG<end>
vnoremap < <gv
vnoremap > >gv
cmap w!! %!sudo tee > /dev/null %
autocmd! bufwritepost .vimrc nested source %

" Bubble single&multiple lines
vnoremap <C-Up> <esc>`>gv:m '>+1<cr>gv
vnoremap <C-Down> <esc>`<gv:m '<-2<cr>gv
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

" Rgrep
map <C-f> :Rgrep<cr>
let Grep_Default_Filelist = '*.*'
let Grep_Skip_Files = '*.log *.sql *.png *.jpg *.jpeg *.gif'
let Grep_Skip_Dirs = 'tmp system coverage log solr public'

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

" FuzzyFinder
let g:fuf_file_exclude =  '\v\~$|\.(bak|swp|png|jpg|jpeg|log|sql|bmp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_coveragefile_exclude = '\v\~$|\.(bak|swp|png|jpg|jpeg|log|sql|bmp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_enumeratingLimit = 30
map <A-S-o> :FufCoverageFile<CR>
nnoremap <silent> <tab> :FufBuffer<CR>
map <F5> :FufRenewCache<cr>

" NerdCommenter
map <C-c> :call NERDComment(0,"toggle")<CR>

" Rails
map gv :Rview<CR>
map gc :Rcontroller<CR>
map gm :Rmodel<CR>
map gh :Rhelper<CR>
map gj :Rjavascript<CR>
map gs :Rstylesheet<CR>

" ruby
autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby let g:rubycomplete_rails = 1
autocmd FileType ruby let g:rubycomplete_classes_in_global = 1
"improve autocomplete menu color
"highlight Pmenu ctermbg=238 gui=bold

" to start vim maximized
function Maximize_Window()
  silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction
au GUIEnter * call Maximize_Window()

if exists("+undofile")
    set udf
    set undodir=~/.vim/undo
endif
