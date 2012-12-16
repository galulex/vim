filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Plugins
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/snipmate-snippets'
Bundle 'garbas/vim-snipmate'
Bundle 'Townk/vim-autoclose'
Bundle 'kchmck/vim-coffee-script'
Bundle 'bbommarito/vim-slim'
Bundle 'digitaltoad/vim-jade'
Bundle 'pangloss/vim-javascript'
Bundle 'briancollins/vim-jst'

Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'

Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-ragtag'

Bundle 'tabpage.vim'
Bundle 'Tab-Menu'
Bundle 'grep.vim'
Bundle 'VIM-Color-Picker'
Bundle 'L9'
Bundle 'FuzzyFinder'

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
filetype plugin on                " Turn on file type detection.
filetype indent on                " Turn on file indent detection.

autocmd BufWritePre *.* :%s/\s\+$//e
:map <C-s> :w<cr>
:imap <C-s> <ESC>:w<cr>
nnoremap <esc> :noh<return><esc>
:map <C-a> <esc>ggVG<end>
vnoremap < <gv
vnoremap > >gv

" run rspec file
autocmd Filetype,BufNewFile *_spec.rb nmap <Leader>r :!bundle exec rspec %<CR>
" run current rspec test
autocmd Filetype,BufNewFile *_spec.rb nmap <Leader>R :exe "!bundle exec rspec %\:" . line(".")<cr>

" Tabs
:nmap <C-S-tab> :tabprevious<cr>
:nmap <C-tab> :tabnext<cr>
:nmap <C-t> :tabnew<cr>
:map <C-t> :tabnew<cr>
:map <C-S-tab> :tabprevious<cr>
:map <C-tab> :tabnext<cr>
:map <tc> :tabclose<cr>
:imap <C-S-tab> <ESC>:tabprevious<cr>i
:imap <C-tab> <ESC>:tabnext<cr>i
:imap <C-t> <ESC>:tabnew<cr>
:map <C-e> <ESC>:q!<cr>

" Rgrep
:map <C-f> :Rgrep<cr>
:let Grep_Default_Filelist = '*.*'
:let Grep_Skip_Files = '*.log *.sql'
:let Grep_Skip_Dirs = 'tmp system public coverage log solr'

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

" FuzzyFinder
let g:fuzzy_ignore = "*.png;*.jpeg;*.jpg;*.gif;*.log;public/**/*;log/**/*;coverage/**/*;tmp/**/*;.git/**/*;.sass-cache/**/*;"
let g:fuf_enumeratingLimit = 30
:map <A-S-o> :FufCoverageFile<cr>
nnoremap <silent> <tab> :FufBuffer<CR>

" NerdCommenter
:map <C-c> :call NERDComment(0,"toggle")<cr>
:imap <C-c> :call NERDComment(0,"toggle")<cr>i

" Rails
:map gv :Rview<cr>
:map gc :Rcontroller<cr>
:map gm :Rmodel<cr>
:map gh :Rhelper<cr>

" to start vim maximized
function Maximize_Window()
  silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction
au GUIEnter * call Maximize_Window()
