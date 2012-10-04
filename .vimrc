" Vim
colo railscasts
set number
set expandtab ts=2 sw=2 ai
set showtabline=2                 " Always shows tabs on top
set backspace=indent,eol,start    " Intuitive backspacing.
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set scrolloff=10                  " Show 3 lines of context around the cursor.
set visualbell                    " No beeping.
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
filetype indent on                " Turn on file type detection.
set noswapfile                    " Disable swp files
set shortmess=filmnrxtTI          " Disble intro message
set nohidden                      " Remove the buffer after tab close
set novisualbell
set list
set listchars=trail:•

autocmd BufWritePre *.* :%s/\s\+$//e
:map <C-s> :w<cr>
:imap <C-s> <ESC>:w<cr>
nnoremap <esc> :noh<return><esc>
:map <C-a> <esc>ggVG<end>

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
let g:fuzzy_matching_limit = 10
:map <A-S-o> :FuzzyFinderTextMate<cr>
:map <F5> :ruby finder.rescan!<cr> " fuzzyfinder refresh
nnoremap <silent> <tab> :FuzzyFinderBuffer<CR>

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
