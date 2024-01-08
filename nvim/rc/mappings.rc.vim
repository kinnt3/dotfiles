"-----------------------------------------------------------------------------
" Key-mappings:

let g:mapleader = 's'
nnoremap s <Nop>

" Indent
nnoremap > >>
nnoremap < <<
xnoremap > >gv
xnoremap < <gv

" Enable undo <C-w> and <C-u>.
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>
inoremap <C-k> <C-o>D

" Useful save mappings.
nnoremap <Leader><Leader> <Cmd>silent update<CR>

" Window
nnoremap <Leader>v <Cmd>vsplit<CR>
nnoremap <Leader>h <Cmd>split<CR>
nnoremap <Leader>o <Cmd>only<CR>
nnoremap <Tab>     <Cmd>wincmd w<CR>

" Search
nnoremap / /\v
nnoremap ? ?\v
nnoremap <Leader>/ /
nnoremap <Leader>? ?

" Better x
nnoremap x "_x

" Smart <C-f>, <C-b>.
noremap <expr> <C-f> max([winheight(0) - 2, 1])
      \ .. '<C-d>' .. (line('w$') >= line('$') ? 'L' : 'M')
noremap <expr> <C-b> max([winheight(0) - 2, 1])
      \ .. '<C-u>' .. (line('w0') <= 1 ? 'H' : 'M')

" Disable ZZ.
nnoremap ZZ <Nop>

" Redraw.
nnoremap <C-l> <Cmd>noh<CR><Cmd>redraw!<CR>

" If press l on fold, fold open.
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
" If press l on fold, range fold open.
xnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'

" Substitute.
xnoremap s :s//g<Left><Left>

" Easy escape.
inoremap jj <ESC>
cnoremap <expr> j
      \ getcmdline()[getcmdpos()-2] ==# 'j' ? '<BS><C-c>' : 'j'
inoremap j<Space> j

" Yank to the end
nnoremap Y y$

" Tag
nnoremap <silent> <C-]> g<C-]>
nnoremap <silent> <C-w>} <C-w>g}

noremap ; :
noremap : ;
nnoremap ' `

" Tab
nnoremap <C-n> gt
nnoremap <C-p> gT
nnoremap gT :tabfirst<CR>
nnoremap gt :tablast<CR>
nnoremap <C-k> :tablast <bar> tabnew<CR>

" Terminal
tnoremap <Esc> <C-\><C-n>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

inoremap <A-h> <C-\><C-n><C-w>h
inoremap <A-j> <C-\><C-n><C-w>j
inoremap <A-k> <C-\><C-n><C-w>k
inoremap <A-l> <C-\><C-n><C-w>l

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Cmdline
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-g> <C-c>
cnoremap <C-k> <Cmd>call setcmdline(
      \ getcmdpos() ==# 1 ? '' : getcmdline()[:getcmdpos() - 2])<CR>
cnoremap <A-b> <S-Left>
cnoremap <A-f> <S-Right>
cnoremap <expr> / (getcmdtype() == '/') ? '\/' : '/'

" Increment
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv

" Line break without entering insert mode
nnoremap go o<ESC>
nnoremap gO O<ESC>

" Visual mode search
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap ? :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
  let temp = @s
  normal! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" Change the current directory
" nnoremap <Leader>cd :cd %:h<CR>
" nnoremap <Leader>lcd :lcd %:h<CR>

" Open Filer
if has('win32')
  nnoremap <silent> <F3> :<C-u>!start .<CR>
elseif has('mac')
  nnoremap <silent> <F3> :<C-u>!open .<CR>
endif
nnoremap <F4> <Cmd>call dein#recache_runtimepath()<CR>
nnoremap <F5> <Cmd>call dein#update()<CR>

nmap <Space> [Space]
nnoremap [Space] <Nop>

nnoremap ^ 0
nnoremap 0 ^
nnoremap & :&&<CR>
xnoremap & :&&<CR>

command! -bang -bar -complete=file -nargs=? Utf8
      \ edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Iso2022jp
      \ edit<bang> ++enc=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? Cp932
      \ edit<bang> ++enc=cp932 <args>
command! -bang -bar -complete=file -nargs=? Euc
      \ edit<bang> ++enc=euc-jp <args>
command! -bang -bar -complete=file -nargs=? Utf16
      \ edit<bang> ++enc=ucs-2le <args>

command! -bang -complete=file -nargs=? WUnix
      \ write<bang> ++fileformat=unix <args> | edit <args>
command! -bang -complete=file -nargs=? WDos
      \ write<bang> ++fileformat=dos <args> | edit <args>

" Insert special character
inoremap <C-v>u  <C-r>=nr2char(0x)<Left>

" Make session
let s:session_path = expand('~/.vim/sessions')
if !s:session_path->isdirectory()
  call mkdir(session_path, "p")
endif
command! -bang -bar -nargs=1 SaveSession
      \ execute 'mksession<bang> ' .. s:session_path .. '/' .. <q-args>
command! -bar -nargs=1 LoadSession
      \ execute 'silent source ' .. s:session_path .. '/' .. <q-args>
command! -bar -nargs=1 DeleteSession
      \ execute 'call delete(' .. s:session_path .. '/' .. <q-args> .. ')'

nnoremap <C-s> <Cmd>SaveSession! default<CR>
nnoremap g<C-l> <Cmd>LoadSession default<CR>
nnoremap g<C-d> <Cmd>DeleteSession default<CR>

