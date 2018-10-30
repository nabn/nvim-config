function helpers#ReverseBackground()
  let Mysyn=&syntax
  if &bg=="light"
    se bg=dark
    highlight Normal guibg=black guifg=white
  else
    se bg=light
    highlight Normal guibg=white guifg=black
  endif
  syn on
  exe "set syntax=" . Mysyn
endfunction

function helpers#DeleteHiddenBuffers()
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction
