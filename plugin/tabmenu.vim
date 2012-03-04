if has('gui_running')
  au TabEnter * call ShowTab()
endif

function! ShowTab()
  silent! aunmenu T&ab
  let in = 1
  let commands = []
  for i in range(tabpagenr('$'))
    let commands += [' T&ab.&' . Krishna(in) . ' :tabnext ' . in . '<CR>']
    let in = in + 1
  endfor
  let sortedCommands = sort(commands, "KrishnaCompare")
  let in = 10
  for i in commands
	let name = 'an 120.' . in . ' ' . i
	let in = in + 1
	exe name
  endfor
endfunction

function! KrishnaCompare(i1, i2)
	return a:i1 ==? a:i2 ? 0 : a:i1 >? a:i2 ? 1 : -1
endfunction

function! TabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction

func! BKrishna(fname)
  let name = a:fname
  if g:bmenu_max_pathlen < 5
    let name = ""
  else
    let len = strlen(name)
    if len > g:bmenu_max_pathlen
      let amountl = (g:bmenu_max_pathlen / 2) - 2
      let amountr = g:bmenu_max_pathlen - amountl - 3
      let pattern = '^\(.\{,' . amountl . '}\).\{-}\(.\{,' . amountr . '}\)$'
      let left = substitute(name, pattern, '\1', '')
      let right = substitute(name, pattern, '\2', '')
      if strlen(left) + strlen(right) < len
        let name = left . '...' . right
      endif
    endif
  endif
  return name
endfunc

func! Krishna(index)
  let name = TabLabel(a:index)
  if name == ''
    if !exists("g:menutrans_no_file")
      let g:menutrans_no_file = "[No file]"
    endif
    let name = g:menutrans_no_file
  else
    let name = fnamemodify(name, ':p:~')
  endif
  " detach file name and separate it out:
  let name2 = fnamemodify(name, ':t')
  let name1 = BKrishna(fnamemodify(name,':h'))
  let name = name2 . " (" . a:index . ")\t" . name1
  let name = escape(name, "\\. \t|")
  let name = substitute(name, "&", "&&", "g")
  let name = substitute(name, "\n", "^@", "g")
  return name
endfunc
