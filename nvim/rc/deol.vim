" hook_add {{{
nnoremap [Space]s
      \ <Cmd>call deol#start(#{
      \   command: 'pwsh',
      \   start_insert: v:false,
      \ })<CR>
nnoremap <Leader>D  <Cmd>call deol#kill_editor()<CR>
nnoremap [ddu]t <Cmd>Ddu -name=deol -sync
      \ -ui-param-split=`has('nvim') ? 'floating' : 'horizontal'`
      \ -ui-param-winRow=1 -ui-param-autoResize
      \ -ui-param-cursorPos=`tabpagenr()-1`
      \ deol<CR>
" }}}

" hook_source {{{
let g:deol#enable_dir_changed = v:false
let g:deol#internal_history_path = '~/.cache/deol-history'

tnoremap <C-t> <Tab>
tnoremap <expr> <Tab> pum#visible() ?
      \ '<Cmd>call pum#map#select_relative(+1)<CR>' :
      \ '<Tab>'
tnoremap <expr> <S-Tab> pum#visible() ?
      \ '<Cmd>call pum#map#select_relative(-1)<CR>' :
      \ '<S-Tab>'
tnoremap <Down>   <Cmd>call pum#map#insert_relative(+1)<CR>
tnoremap <Up>     <Cmd>call pum#map#insert_relative(-1)<CR>
tnoremap <C-y>    <Cmd>call pum#map#confirm()<CR>
tnoremap <C-o>    <Cmd>call pum#map#confirm()<CR>
" }}}

" deol {{{
nnoremap <buffer> [Space]gc
      \ <Cmd>call deol#send('git commit')<CR>
nnoremap <buffer> [Space]gs
      \ <Cmd>call deol#send('git status')<CR>
nnoremap <buffer> [Space]gA
      \ <Cmd>call deol#send('git commit --amend')<CR>
nnoremap <buffer> e <Plug>(deol_edit)
tmap <buffer><expr> <CR>
      \ (pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '')
      \ .. '<Plug>(deol_execute_line)'

call ddc#custom#patch_buffer('sourceOptions', #{
      \   _: #{
      \     converters: [],
      \   },
      \ })
" }}}
