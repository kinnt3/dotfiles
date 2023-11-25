" ----------------------------------------------------------------------------
" Base
set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,euc-jp,cp932
set packpath=

" ----------------------------------------------------------------------------
" Search
set ignorecase
set smartcase
set incsearch
set hlsearch
set wrapscan

" ----------------------------------------------------------------------------
" Edit:
set nofixeol          "最後に改行のないファイルを編集したときに改行を付けない
set clipboard=unnamed "clipboard register にコピー
set number
set showmatch         "対応する括弧を表示
set cursorline
set cindent
set cinoptions=g1,N-s,h1,l1,j1
set scrolloff=9  "カーソルの上または下に表示される最低行数
set pumblend=15
set winblend=15
if has('win32')
  set ambiwidth=single
else
  set ambiwidth=double
endif
set mouse=a

set tabstop=2     "画面上でのタブ幅
set expandtab     "タブ入力時に半角スペース入れる
set shiftwidth=2  "|'cindent'|, |>>|, |<<|, で使う
set shiftround

set autoindent
set smartindent

set modelines=2 "ファイルの上下の端から指定した行数だけモードラインを探す
set nomodeline

set backspace=indent,eol,start

set matchpairs+=<:>

set hidden

set nofoldenable
set foldmethod=manual
set foldcolumn=auto:1
set commentstring=%s

set timeout timeoutlen=500 ttimeoutlen=100

set updatetime=1000

set directory-=.
set undofile

set virtualedit=block

autocmd MyAutoCmd InsertLeave *
      \ : if &paste
      \ |   setlocal nopaste
      \ |   echo 'nopaste'
      \ | endif

autocmd MyAutoCmd InsertLeave *
      \ : if &l:diff
      \ |   diffupdate
      \ | endif

set diffopt=internal,algorithm:patience,indent-heuristic

autocmd MyAutoCmd BufWritePre *
      \ call s:mkdir_as_necessary('<afile>:p:h'->expand(), v:cmdbang)
function s:mkdir_as_necessary(dir, force) abort
  if a:dir->isdirectory() || &l:buftype !=# ''
    return
  endif

  const message = printf('"%s" does not exist. Create? [y/N] ', a:dir)
  if a:force || message->input() =~? '^y\%[es]$'
    call mkdir(a:dir->iconv(&encoding, &termencoding), 'p')
  endif
endfunction

set helplang& helplang=en,ja

set spelllang+=cjk
set spelloptions+=camel

set fileformat=dos
set fileformats=dos,unix,mac

let g:editorconfig = v:false


"-----------------------------------------------------------------------------
" View:
set list
if has('win32')
   set listchars=tab:>-,trail:-,precedes:<
else
   set listchars=tab:▸\ ,trail:-,precedes:«,nbsp:%
endif

" Does not report lines
set report=1000

set cmdheight=1

set nowrap
set whichwrap+=h,l,<,>,[,],b,s,~
set breakindent

set nowritebackup
set nobackup
set noswapfile
set backupdir-=.

set t_vb=
set novisualbell
set belloff=all

set wildmenu
set wildmode=full

set showfulltag
set wildoptions+=tagfile
set wildignorecase

set history=200
set shada='100,<20,s10,h,r/tmp/,rterm:

let g:did_install_default_menus = v:true

set completeopt=menuone
set complete=.
set pumheight=5
set pumwidth=0
set completeslash=slash

set omnifunc=v:lua.vim.lsp.omnifunc

set nostartofline

set splitbelow
set splitright
set noequalalways

set previewheight=8
set helpheight=12

set ttyfast

set display+=uhex

set conceallevel=2

set colorcolumn=79

set redrawtime=0

set nomore
