" tabpage.vim: Beautify the tab pages
" Last Change: 2011-08-26 
" Maintainer:  Tian Huixiong: <nedzqbear@gmail.com>
" Licence:     This script is released under the Vim License.
" Version:     1.0
" Install:     
"         Put this file in ~/.vim/plugin on Linux
"         Or put it in $vim/vimfiles/plugin on Windows
" Mappings:
"         I have comment all the mappings to avoid conflict with yours.
"         You can uncomment them.
" Tutorial:
"         This script is very simple, just beautify the default tab page
"
"         1.  Remove the path, only show filename
"         2.  Add number to each tab page
"         3.  If buffer has been modified, add * to the title
"             This works on GVIM.
"         4.  Limit the width of tab pages
"             All tab pages have the same width, except that who's name is very
"             long.

    " Allways show the tab page
    "set showtabline = 2      
    
    " The width of tab page
    let s:tab_width = 18    

    " 1.  Remove the path, only show filename
    " 2.  Add number to each tab page
    " 3.  If buffer has been modified, add * to the title
    " 4.  Limit the width of tab pages
    function! MyTabLabel ()
        let bufnrlist = tabpagebuflist (v:lnum)
        let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
        let filename = fnamemodify (label, ':t')
        let prefix = (v:lnum) . "." . "  "

        for bufnr in bufnrlist
            if getbufvar(bufnr, "&modified")
                let filename .= ' *'
                break
            endif
        endfor

        let blank_len = s:tab_width - strlen(prefix) - strlen(filename)
        let i = 0
        while i < blank_len
            let prefix = prefix . " "
            let i += 1
        endwhile
        return prefix . filename
    endfunction

    set guitablabel=%{MyTabLabel()}


    " Use Tab to switch tab pages
    "nmap <tab> gt

    " Use Alt + num to switch tab pages
    nnoremap <silent><M-1> 1gt
    nnoremap <silent><M-2> 2gt
    nnoremap <silent><M-3> 3gt
    nnoremap <silent><M-4> 4gt
    nnoremap <silent><M-5> 5gt
    nnoremap <silent><M-6> 6gt
    nnoremap <silent><M-7> 7gt
    nnoremap <silent><M-8> 8gt
    nnoremap <silent><M-9> 9gt
    nnoremap <silent><M-0> 10gt
    
    function! TabMove(destTabID)
        exe "tabm " . string(a:destTabID - 1)
    endfunction

    " Move the tab pages
    " tm1: move current tab page to the first
    " tm2: move current tab page to the second
    " ... ...
    "nnoremap <silent>tm1  :call TabMove(1)<cr>
    "nnoremap <silent>tm2  :call TabMove(2)<cr>
    "nnoremap <silent>tm3  :call TabMove(3)<cr>
    "nnoremap <silent>tm4  :call TabMove(4)<cr>
    "nnoremap <silent>tm5  :call TabMove(5)<cr>
    "nnoremap <silent>tm6  :call TabMove(6)<cr>
    "nnoremap <silent>tm7  :call TabMove(7)<cr>
    "nnoremap <silent>tm8  :call TabMove(8)<cr>
    "nnoremap <silent>tm9  :call TabMove(9)<cr>
    "nnoremap <silent>tm10 :call TabMove(10)<cr>

function MoveCurrentTab(value)
  if a:value == 0
    return
  endif
  let move = a:value - 1
  let move_to = tabpagenr() + move
  if move_to < 0
    let move_to = 0
  endif
  exe 'tabmove '.move_to
endfunction

map <silent> <M-PageUp> :call MoveCurrentTab(-1)<Esc>
map <silent> <M-PageDown> :call MoveCurrentTab(1)<Esc>

