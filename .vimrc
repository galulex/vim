colo railscasts
set showtabline=2 "Always shows tabs on top
filetype plugin indent on         " Turn on file type detection.
set expandtab ts=2 sw=2 ai
set number

"Tabs settings
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
nnoremap <silent> <tab> :BufExplorer<CR>

:map <C-f> :Rgrep<cr>

" FuzzyFinder plugin settings
:map <A-S-o> :FuzzyFinderTextMate<cr>
:map <F5> :ruby finder.rescan!<cr>          " fuzzyfinder refresh

" Rails.vim plugin settings
:map gv :Rview<cr>
:map gc :Rcontroller<cr>
:map gm :Rmodel<cr>

:map <C-s> :w<cr>
:imap <C-s> <ESC>:w<cr>
:map <C-a> <esc>ggVG<end>

:map <F6> :source $MYVIMRC<cr>

set backspace=indent,eol,start    " Intuitive backspacing.
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set scrolloff=10                  " Show 3 lines of context around the cursor.
set visualbell                    " No beeping.
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile
set novisualbell
