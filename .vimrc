colo railscasts
set showtabline=2 "Always shows tabs on top

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