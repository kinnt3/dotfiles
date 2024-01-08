" hook_add {{{

" markdown
let g:vim_markdown_frontmatter = v:true
let g:vim_markdown_toml_frontmatter = v:true
let g:vim_markdown_json_frontmatter = v:true
let g:vim_markdown_no_default_key_mappings = v:true

" Enable modeline for only Vim help files.
autocmd MyAutoCmd BufRead,BufWritePost *.txt,*.jax setlocal modeline

" Disable quotes keyword.
autocmd MyAutoCmd BufEnter,BufRead,BufNewFile *.md setlocal iskeyword-='

" Update filetype.
autocmd MyAutoCmd BufWritePost * nested
\ : if &l:filetype ==# '' || 'b:ftdetect'->exists()
\ |   unlet! b:ftdetect
\ |   silent filetype detect
\ | endif

" Disable default plugins.
let g:loaded_2html_plugin      = v:true
let g:loaded_logiPat           = v:true
let g:loaded_getscriptPlugin   = v:true
let g:loaded_gzip              = v:true
let g:loaded_gtags             = v:true
let g:loaded_gtags_cscope      = v:true
" let g:loaded_man               = v:true
" let g:loaded_matchit           = v:true
" let g:loaded_matchparen        = v:true
let g:loaded_netrwFileHandlers = v:true
let g:loaded_netrwPlugin       = v:true
let g:loaded_netrwSettings     = v:true
let g:loaded_rrhelper          = v:true
let g:loaded_shada_plugin      = v:true
let g:loaded_spellfile_plugin  = v:true
let g:loaded_tarPlugin         = v:true
let g:loaded_tutor_mode_plugin = v:true
let g:loaded_vimballPlugin     = v:true
let g:loaded_zipPlugin         = v:true
" }}}

" _ {{{
" Disable automatically insert comment.
setl formatoptions-=t
setl formatoptions-=c
setl formatoptions-=r
setl formatoptions-=o
setl formatoptions+=mMBl

" Disable auto wrap.
if &l:textwidth != 70 && &filetype !=# 'help'
  setlocal textwidth=0
endif

if !&l:modifiable
  setlocal nofoldenable
  setlocal foldcolumn=0
  setlocal colorcolumn=
endif
" }}}

" python {{{
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab
setlocal nosmartindent
" }}}

" vim {{{
setlocal shiftwidth=2 softtabstop=2
setlocal iskeyword+=:,#
setlocal indentkeys+=\\,endif,endfunction,endfor,endwhile,endtry
" }}}

" help {{{
setlocal iskeyword+=:
setlocal iskeyword+=#
setlocal iskeyword+=-
setlocal conceallevel=0
" }}}

" toml {{{
setlocal foldenable foldmethod=expr foldexpr=s:fold_expr(v:lnum)
function! s:fold_expr(lnum)
  const line = getline(a:lnum)
  return line ==# '' || line =~# '^\s\+'
endfunction
" }}}
