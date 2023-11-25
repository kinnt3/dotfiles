let $CACHE = '~/.cache'->expand()
if !($CACHE->isdirectory())
  call mkdir($CACHE, 'p')
endif

for s:plugin in [
      \ 'Shougo/dein.vim',
      \ ]->filter({ _, val -> &runtimepath !~# '/' .. val })
  " Search from current directory
  let s:dir = 'dein.vim'->fnamemodify(':p')
  if !(s:dir->isdirectory())
    " Search from $CACHE directory
    let s:dir = $CACHE .. '/dein/repos/github.com/' .. s:plugin
    if !(s:dir->isdirectory())
      execute '!git clone https://github.com/' .. s:plugin s:dir
    endif
  endif
  execute 'set runtimepath^='
        \ .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endfor


"---------------------------------------------------------------------------
" dein configurations.

let g:dein#auto_recache = !has('win32')
let g:dein#auto_remote_plugins = v:true
let g:dein#default_options = #{ merged: v:true }
let g:dein#enable_notification = v:true
let g:dein#install_check_diff = v:true
let g:dein#install_check_remote_threshold = 24 * 60 * 60
let g:dein#install_max_processes = 32
let g:dein#install_process_timeout = 12000
let g:dein#install_progress_type = 'floating'
let g:dein#lazy_rplugins = v:true
let g:dein#types#git#clone_depth = 1
let g:dein#types#git#command_path = expand('~/scoop/shims/git')
let g:dein#types#git#enable_partial_clone = v:true

let $BASE_DIR = '<sfile>'->expand()->fnamemodify(':h')

let s:path = $CACHE .. '/dein'
let g:dein_load_state = !dein#min#load_state(s:path)
if g:dein_load_state
  finish
endif

let g:dein#inline_vimrcs = [
      \ '$BASE_DIR/options.rc.vim',
      \ '$BASE_DIR/mappings.rc.vim',
      \ ]
if has('win32')
  call add(g:dein#inline_vimrcs, '$BASE_DIR/windows.rc.vim')
endif

call dein#begin(s:path, '<sfile>'->expand())

call dein#load_toml('$BASE_DIR/dein.toml', #{ lazy: 0 })
call dein#load_toml('$BASE_DIR/deinlazy.toml', #{ lazy: 1 })
call dein#load_toml('$BASE_DIR/denops.toml', #{ lazy: 1 })
call dein#load_toml('$BASE_DIR/ddc.toml', #{ lazy: 1 })
call dein#load_toml('$BASE_DIR/ddu.toml', #{ lazy: 1 })

const work_directory = '~/work'->expand()
if work_directory->isdirectory()
  " Load develop version plugins.
  call dein#local(work_directory,
        \ #{ frozen: 1, merged: 0 }, [])
endif

call dein#end()
call dein#save_state()

if dein#check_install()
  call dein#install()
endif

if !empty(dein#check_clean())
  call map(dein#check_clean(), { _, val -> delete(val, 'rf') })
  call dein#recache_runtimepath()
endif
