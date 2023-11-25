" hook_add {{{

nnoremap [ddu] <Nop>
nmap , [ddu]

nnoremap [ddu]<Space><Space> <Cmd>call StartDdu('bookmark')<CR>
nnoremap [ddu]<Space>u       <Cmd>call StartDdu('bookmark_u')<CR>
nnoremap [ddu]b              <Cmd>call StartDdu('buffer')<CR>
nnoremap [ddu]c              <Cmd>call StartDdu('file_current')<CR>
nnoremap [ddu]gg             <Cmd>call StartDdu('rg')<CR>
nnoremap [ddu]gr             <Cmd>call StartDdu('rg_register')<CR>
nnoremap [ddu]gl             <Cmd>call StartDdu('rg_live')<CR>
nnoremap [ddu]pg             <Cmd>call StartDdu('rg_pm')<CR>
nnoremap [ddu]w              <Cmd>call StartDdu('rg_cword')<CR>
nnoremap [ddu]pw             <Cmd>call StartDdu('rg_cword_pmatch')<CR>
nnoremap [ddu]dw             <Cmd>call StartDdu('rg_cword_cdir')<CR>
nnoremap [ddu]h              <Cmd>call StartDdu('history')<CR>
nnoremap [ddu]/              <Cmd>call StartDdu('line')<CR>
nnoremap [ddu]*              <Cmd>call StartDdu('line_cword')<CR>
nnoremap [ddu]re             <Cmd>call StartDdu('register')<CR>
xnoremap [ddu]re             <Cmd>call StartDdu('register_visual')<CR>
nnoremap [ddu]rg             <Cmd>call StartDdu('search_resume')<CR>
nnoremap [ddu]r<Space>       <Cmd>call StartDdu('file_rec_resume')<CR>
nnoremap [ddu]de             <Cmd>call StartDdu('dein')<CR>
nnoremap <C-o>               <Cmd>call StartDdu('jumplist')<CR>

function! StartDdu(name) abort
  let name = a:name
  if name ==# 'bookmark'
    call ddu#start(#{
          \   name: 'bookmark', 
          \   sources: [
          \     #{ name: 'bookmark' },
          \   ],
          \ })
  elseif name ==# 'bookmark_u'
    call ddu#start(#{
          \   name: 'bookmark', 
          \   sources: [
          \     #{ name: 'bookmark', params: {'group': 'u'} },
          \   ],
          \ })
  elseif name ==# 'buffer'
    call ddu#start(#{
          \   name: 'buffer', 
          \   sources: [
          \     #{ name: 'buffer' },
          \   ],
          \ })
  elseif name ==# 'file_current'
    call ddu#start(#{
          \   name: 'files', 
          \   sources: [
          \     #{ name: 'file', options: #{ path: expand('%:p:h') } },
          \   ],
          \ })
  elseif name ==# 'rg'
    let word = 'Pattern: '->input()
    if !empty(word)
      call ddu#start(#{ 
            \   name: 'search',
            \   sources: [
            \     #{ name: 'rg', params: #{ input: word } },
            \   ],
            \ })
    endif
  elseif name ==# 'rg_register'
    let word = 'Pattern: '->input()
    if !empty(word)
      call ddu#start(#{ 
            \   name: 'search',
            \   sources: [
            \     #{ name: 'rg', params: #{ input: v:register->getreg() } },
            \   ],
            \ })
    endif
  elseif name ==# 'rg_live'
    call ddu#start(#{
          \   sources: [#{
          \     name: 'rg',
          \     options: #{
          \       matchers: [],
          \       volatile: v:true,
          \     },
          \   }],
          \   uiParams: #{ ff: #{
          \     ignoreEmpty: v:false,
          \     autoResize: v:false,
          \   }},
          \ })
  elseif name ==# 'rg_pm'
    let word = 'Pattern: '->input()
    if !empty(word)
      let args = ddu#custom#get_global().rg.args + ['--word_regexp']
      call ddu#start(#{ 
            \   name: 'search',
            \   sources: [
            \     #{ name: 'rg', params: #{ input: word, args: args } },
            \   ],
            \ })
    endif
  elseif name ==# 'rg_cword'
    let word = 'Pattern: '->input('<cword>'->expand())
    if !empty(word)
      call ddu#start(#{ 
            \   name: 'search',
            \   sources: [
            \     #{ name: 'rg', params: #{ input: word } },
            \   ],
            \ })
    endif
  elseif name ==# 'rg_cword_pmatch'
    let word = 'Pattern: '->input('<cword>'->expand())
    if !empty(word)
      let args = ddu#custom#get_global().rg.args + ['--word_regexp']
      call ddu#start(#{ 
            \   name: 'search',
            \   sources: [
            \     #{ name: 'rg', params: #{ input: word, args: args } },
            \   ],
            \ })
    endif
  elseif name ==# 'rg_cword_cdir'
    let word = 'Pattern: '->input()
    let dir = 'Directory: '->input($'{getcwd()}/', 'dir')
    call ddu#start(#{ 
          \   name: 'search',
          \   sources: [
          \     #{ name: 'rg', params: #{ input: expand('<cword>') }, options: #{ path: dir } },
          \   ],
          \ })
  elseif name ==# 'history'
    call ddu#start(#{
          \   name: 'history', 
          \   sources: [
          \     #{ name: 'file_old' },
          \   ],
          \ })
  elseif name ==# 'line'
    call ddu#start(#{
          \   name: 'search', 
          \   sources: [
          \     #{ name: 'line' },
          \   ],
          \ })
  elseif name ==# 'line_cword'
    call ddu#start(#{
          \   name: 'search', 
          \   sources: [
          \     #{ name: 'line', params: #{ input: expand('<cword>') } },
          \   ],
          \ })
  elseif name ==# 'register'
    call ddu#start(#{
          \   name: 'register', 
          \   sources: [
          \     #{ name: 'register', options: #{ defaultAction: '.'->col() == 1 ? 'insert' : 'append' } },
          \   ],
          \   uiParams: #{
          \     ff: #{
          \       autoResize: v:true,
          \     },
          \   },
          \ })
  elseif name ==# 'register_visual'
    ('normal ' . mode() ==# 'V' ? '"_R<ESC>' : '"_d')->execute()
    call ddu#start(#{
          \   name: 'register', 
          \   sources: [
          \     #{ name: 'register', options: #{ defaultAction: 'insert' } },
          \   ],
          \   uiParams: #{
          \     ff: #{
          \       autoResize: v:true,
          \     },
          \   },
          \ })
  elseif name ==# 'search_resume'
    call ddu#start(#{
          \   name: 'search', 
          \   resume: v:true,
          \ })
  elseif name ==# 'file_rec_resume'
    call ddu#start(#{
          \   name: 'file_rec', 
          \   resume: v:true,
          \ })
  elseif name ==# 'dein'
    call ddu#start(#{
          \   name: 'dein', 
          \   sources: [
          \     #{ name: 'dein' },
          \   ],
          \ })
  elseif name ==# 'jumplist'
    call ddu#start(#{
          \   name: 'jumplist', 
          \   sources: [
          \     #{ name: 'jumplist' },
          \   ],
          \ })
  endif
endfunction
" }}}

" hook_source {{{
call ddu#custom#alias('source', 'file_rg', 'file_external')
call ddu#custom#alias('source', 'file_git', 'file_external')
call ddu#custom#alias('action', 'tabopen', 'open')

call ddu#custom#patch_global(#{
      \   ui: 'ff',
      \   sync: v:true,
      \   uiParams: #{
      \     ff: #{
      \       autoAction: #{
      \         name: 'preview',
      \       },
      \       filterSplitDirection: 'floating',
      \       split: 'floating',
      \       autoResize: v:true,
      \       floatingBorder: 'double',
      \       highlights: #{
      \         filterText: "Statement",
      \         floating: "Normal",
      \         floatingBorder: "Special",
      \       },
      \       previewFloating: v:true,
      \       previewFloatingBorder: "single",
      \     }
      \   },
      \   sourceOptions: {
      \     '_': #{
      \       ignoreCase: v:true,
      \       matchers: ['matcher_substring'],
      \       smartCase: v:true,
      \     },
      \     'file_old': #{
      \       matchers: ['matcher_substring'],
      \       columns: ['icon_filename'],
      \     },
      \     'file_rec': #{
      \       matchers: [
      \         'matcher_substring',
      \         'matcher_hidden',
      \       ],
      \       converters: ['converter_hl_dir'],
      \     },
      \     'file_git': #{
      \       matchers: [
      \         'matcher_relative',
      \         'matcher_substring',
      \       ],
      \       converters: ['converter_hl_dir'],
      \     },
      \     'file': #{
      \       matchers: [
      \         'matcher_substring',
      \         'matcher_hidden',
      \       ],
      \       sorters: ['sorter_alpha'],
      \       converters: ['converter_hl_dir'],
      \       columns: ['icon_filename'],
      \     },
      \     'bookmark': #{
      \       defaultAction: 'candidateFileRecOrEdit',
      \       sorters: [],
      \     },
      \     'rg': #{
      \       matchers: [
      \         'matcher_substring',
      \         'matcher_files',
      \         'converter_display_word',
      \       ],
      \       sorters: ['sorter_alpha'],
      \     },
      \     'dein': #{
      \       defaultAction: 'cd',
      \     },
      \   },
      \   sourceParams: #{
      \     rg: #{
      \       args: [
      \         '--smart-case',
      \         '--column',
      \         '--no-heading',
      \         '--json', 
      \         '--color',
      \         'never',
      \         '-g', '!*.{sln,bak,filters,vcxproj,user,pbxproj,xml,java,pro}',
      \         '-g', '!tags'
      \       ],
      \     },
      \     file_rec: #{
      \       ignoredDirectories: ['.git', 'projects', 'lib'],
      \       chunkSize: 15000,
      \     },
      \     file_rg: #{
      \       cmd: [
      \         "rg",
      \         "--files",
      \         "--glob",
      \         "!.git",
      \         "--color",
      \         "never",
      \         "--no-messages",
      \       ],
      \       updateItems: 50000,
      \     },
      \     file_git: #{
      \       cmd: ['git', 'ls-files', '-co', '--exclude-standard'],
      \     },
      \   }, 
      \   kindOptions: #{
      \     file: {
      \       'defaultAction': 'open',
      \     },
      \     action: #{
      \       defaultAction: 'do',
      \     },
      \     word: #{
      \       defaultAction: 'append',
      \     },
      \   },
      \   kindParams: #{
      \     action: #{
      \       quit: v:true,
      \     },
      \   },
      \   actionOptions: #{
      \     quit: v:true,
      \   },
      \   filterParams: #{
      \     matcher_substring: #{
      \       highlightMatched: 'Search',
      \     },
      \     matcher_ignore_files: #{
      \       ignoreGlobs: ['test_*.vim'],
      \       ignorePatterns: [],
      \     },
      \     converter_hl_dir: #{
      \       hlGroup: ['Directory', 'Keyword'],
      \     },
      \   },
      \ })

call ddu#custom#action('kind', 'file', 'candidateFileRecOrEdit',
      \ { args -> CandidateFileRecOrEdit(args) })

function! CandidateFileRecOrEdit(args)
  let path = a:args.items[0].action.path
  if path->isdirectory()
    call ddu#start(#{
          \   name: 'file_rec',
          \   sources: [{'name': 'file_rec', 'options': {'path': path}}]
          \ })
  else
    call ddu#util#execute_path("edit", path)
  endif
endfunction
" }}}
