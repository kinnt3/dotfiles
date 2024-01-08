" hook_add {{{
"nnoremap : <Cmd>call CommandlinePre()<CR>:
"xnoremap : <Cmd>call CommandlinePre()<CR>:
"
"function! CommandlinePre() abort
"  " Overwrite sources
"  let b:prev_buffer_config = ddc#custom#get_buffer()
"
"  call ddc#custom#patch_buffer('sourceOptions', #{
"        \   _: #{
"        \     keywordPattern: '[0-9a-zA-Z_:#-]*',
"        \   },
"        \ })
"
"  autocmd MyAutoCmd User DDCCmdlineLeave ++once call CommandlinePost()
"
"  call ddc#enable_cmdline_completion()
"endfunction
"function! CommandlinePost() abort
"  " Restore config
"  if 'b:prev_buffer_config'->exists()
"    call ddc#custom#set_buffer(b:prev_buffer_config)
"    unlet b:prev_buffer_config
"  endif
"endfunction
" }}}

" hook_source {{{
call ddc#custom#patch_global(#{
      \ ui: 'pum',
      \ autoCompleteEvents: [
      \   'InsertEnter', 'TextChangedI', 'TextChangedP', 
      \   'TextChangedT', 'CmdlineEnter', 'CmdlineChanged',
      \ ],
      \ sources: ['around', 'buffer', 'file', 'line'],
      \ cmdlineSources: {
      \   ':': ['cmdline', 'cmdline-history', 'around'],
      \   '@': ['input', 'cmdline-history', 'file', 'around'],
      \   '>': ['input', 'cmdline-history', 'file', 'around'],
      \   '/': ['around', 'line'],
      \   '?': ['around', 'line'],
      \   '-': ['around', 'line'],
      \   '=': ['input'],
      \ },
      \ sourceOptions: #{
      \   _: #{
      \     ignoreCase: v:true,
      \     matchers: ['matcher_head', 'matcher_length', 'matcher_prefix'],
      \     sorters: ['sorter_rank'],
      \     converters: ['converter_remove_overlap'],
      \   },
      \   around: #{
      \     mark: '[around]',
      \   },
      \   buffer: #{
      \     mark: '[buffer]',
      \   },
      \   vim: #{
      \     mark: '[vim]',
      \   },
      \   cmdline: #{
      \     mark: '[cmdline]',
      \     forceCompletionPattern: '\S/\S*|\.\w*',
      \   },
      \   input: #{
      \     mark: '[input]',
      \     forceCompletionPattern: '\S/\S*',
      \     isVolatile: v:true,
      \   },
      \   file: #{
      \     mark: '[file]',
      \     isVolatile: v:true,
      \     minAutoCompleteLength: 1000,
      \     forceCompletionPattern: '\S/\S*',
      \   },
      \   cmdline-history: #{
      \     mark: '[command-history]',
      \     sorters: [],
      \   },
      \   line: #{
      \     mark: '[line]',
      \     matchers: ['matcher_vimregexp'],
      \   },
      \   codeium: #{
      \     mark: '[codeium]',
      \     matchers: ['matcher_length'],
      \     minAutoCompleteLength: 0,
      \     isVolatile: v:true,
      \   },
      \   lsp: #{
      \     mark: '[lsp]',
      \     forceCompletionPattern: '\.\w*|::\w*|->\w*',
      \     dup: 'force',
      \   },
      \ },
      \ sourceParams: #{
      \   buffer: #{
      \     requireSameFiletype: v:false,
      \   },
      \   around: #{
      \     maxSize: 500,
      \   },
      \   line: #{
      \     maxSize: 1000,
      \   },
      \ },
      \ postFilters: ['sorter_head'],
      \ })

" For insert mode completion
inoremap <expr> <TAB>
      \ pum#visible() ?
      \   '<Cmd>call pum#map#insert_relative(+1, "empty")<CR>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \   '<TAB>' : ddc#map#manual_complete()
inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1, 'empty')<CR>
inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-o>   <Cmd>call pum#map#confirm_word()<CR>
inoremap <Home>  <Cmd>call pum#map#insert_relative(-9999, 'ignore')<CR>
inoremap <End>   <Cmd>call pum#map#insert_relative(+9999, 'ignore')<CR>
inoremap <expr> <C-e> ddc#visible()
      \ ? '<Cmd>call ddc#hide()<CR>'
      \ : '<End>'

" Refresh the completion
inoremap <expr> <C-l>  ddc#map#manual_complete()

" For command line mode completion
"cnoremap <expr> <Tab>
"      \ wildmenumode() ? &wildcharm->nr2char() :
"      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
"      \ ddc#map#manual_complete()
"cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
"cnoremap <C-o>   <Cmd>call pum#map#confirm()<CR>
"cnoremap <C-q>   <Cmd>call pum#map#select_relative(+1)<CR>
"cnoremap <C-z>   <Cmd>call pum#map#select_relative(-1)<CR>
"cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
"cnoremap <expr> <C-e> ddc#visible()
"      \ ? '<Cmd>call ddc#hide()<CR>'
"      \ : '<End>'
"
"cnoremap <expr> <C-t>       ddc#map#insert_item(0)
inoremap <expr> <C-t>
      \ pum#visible() ? ddc#map#insert_item(0) : "\<C-v>\<Tab>"

" For terminal completion
call ddc#enable_terminal_completion()

call ddc#enable(#{
      \   context_filetype: has('nvim') ? 'treesitter' : 'context_filetype',
      \ })
" }}}
