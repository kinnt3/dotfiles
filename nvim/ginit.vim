if 'g:GuiLoaded'->exists()
  GuiTabline v:false
  GuiPopupmenu v:false

  if ':GuiFont'->exists()
    if has('win32')
      GuiFont! Cica:h12
    else
      GuiFont! Cica:h14
    endif
  endif

  nnoremap <silent> <C-6> <C-^>
endif
