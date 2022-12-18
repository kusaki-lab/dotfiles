
" -----------------------------------
" start plugin part
" -----------------------------------
let s:plugin_part = v:true
" let s:plugin_part = v:false
if s:plugin_part && isdirectory(expand('~/.cache/dein'))
" -----------------------------------

"
" VIEW default keymap:<help index.txt>
" Tag Jump:Ctrl-]
" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Set Dein base path (required)
" let s:dein_base = '/home/ubuntu/.cache/dein'
let s:dein_base = $HOME.'/.cache/dein'

" Set Dein source path (required)
" let s:dein_src = '/home/ubuntu/.cache/dein/repos/github.com/Shougo/dein.vim'
let s:dein_src = $HOME.'/.cache/dein/repos/github.com/Shougo/dein.vim'

" Set Dein runtime path (required)
execute 'set runtimepath+=' . s:dein_src

" Call Dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)

" Your plugins go here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
"-------------------------------------------------

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory = '~/src/dotfiles/snippets/'

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"


"-------------
call dein#add('preservim/nerdtree')
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"-------------
call dein#add('itchyny/lightline.vim')

"-------------
call dein#add('preservim/nerdcommenter')
filetype plugin on
let g:NERDSpaceDelims=1
"keymap -> [count]<leader>cc : comment out
"keymap -> [count]<leader>c<space> : toggle comment

"-------------
call dein#add('LeafCage/yankround.vim')
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

"-------------
call dein#add('tpope/vim-surround')
"keymap -> ds[e]    : delete surround [e]
"keymap -> cs[e][e']: change surround [e]
"keymap -> ys[mo][e]: you    surround [e]
"keymap -> S [e]    : @Select-Mode surround [e]
"[e]:(,{,[,<,',""
"[mo]:motion: 0|^|$|iw|aw|s(sentence)|

"-- cf --
"di[e]|da[e]: delete inner/outer [e]
"ci[e]|xa[e]: delete inner/outer [e]

"-------------
call dein#add('kana/vim-textobj-user')

"-------------
call dein#add('osyo-manga/vim-textobj-multiblock')
"text object (*), {*}, [*], <*>, '*', "*"
"keymap -> isb: for inner text object
"keymap -> asb: for outer text object

"-------------
call dein#add('thinca/vim-textobj-between')
"keymap -> if[e]: inner feald between [e]
"keymap -> af[e]: outer feald between [e]

"-------------
call dein#add('jiangmiao/auto-pairs')

"-------------
call dein#add('kana/vim-operator-user')

"-------------
call dein#add('tpope/vim-repeat')

"-------------
call dein#add('kana/vim-operator-replace')
map R <Plug>(operator-replace)
" ex) Riw : replace inner word
" fc. original R: start replace mode

"-------------
call dein#add('rhysd/vim-operator-surround')
map <silent> sa <Plug>(operator-surround-append)
" 括弧を追加する
" ex) saiw( : surround inner word ()
map <silent> sd <Plug>(operator-surround-delete)
" 括弧を削除する
" ex) sda( : delete outer ()
map <silent> sr <Plug>(operator-surround-replace)
" 括弧を入れ替える
" ex) sa"' : change outer " to '

"-------------
call dein#add('yuttie/comfortable-motion.vim')

"-------------
call dein#add('rhysd/clever-f.vim')

"-------------
call dein#add('jeetsukumaran/vim-buffergator')
"keymap -> <leader>b: open buffergator
"keymap -> o : open selected buffer
"keymap -> s : open selected buffer in new vertical split
"keymap -> i : open selected buffer in new horizontal split
"keymap -> t : open selected buffer in new tab
"keymap -> d : delete selected next buffer
"keymap -> <CR> : open selected buffer
"keymap -> <SPACE> : preview next buffer
"keymap -> q : close buffergator

"keymap -> gb : move next buffer
"keymap -> <C-6> : move next buffer

"-------------
call dein#add('junegunn/vim-peekaboo')
" show register vlues

"-------------
call dein#add('terryma/vim-expand-region')
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"-------------
call dein#add('nanotech/jellybeans.vim')

"-------------
" call dein#add('')

"-------------------------------------------------
" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Finish Dein initialization (required)
call dein#end()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" Uncomment if you want to install not-installed plugins on startup.
if dein#check_install()
 call dein#install()
endif

" puigin delete
" call map(dein#check_clean(), { _, val -> delete(val, 'rf') })
" call dein#recache_runtimepath()


" -----------------------------------
" end plugin part
" -----------------------------------
endif



" -----------------------------------
" start basic part
" -----------------------------------
let s:basic_part = v:true
" let s:basic_part = v:false
if s:basic_part
" -----------------------------------

set expandtab     "タブ入力を複数の空白入力に置き換える
set tabstop=2     "画面上でタブ文字が占める幅
set shiftwidth=2  "自動インデントでずれる幅
set softtabstop=2 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    "改行時に前の行のインデントを継続する
set smartindent   "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set laststatus=2
set scrolloff=8
set number
set hidden
set incsearch
set ignorecase
set smartcase
set whichwrap=b,s,[,],<,>,~,h,l
set hlsearch
colorscheme jellybeans
hi Search ctermbg=DarkCyan
hi Search ctermfg=white
set cursorline

" Leaderキーを\から押しやすい<Space>に変更
nnoremap <Space> <nop>
let mapleader="\<Space>"


" nnoremap <Esc> :nohl<CR>
nnoremap <silent> <Esc> :<C-u>nohlsearch<CR><C-l>
nnoremap <Esc><Esc> :nohl<CR>:w<CR>

nnoremap <silent> <C-n> :<C-u>bn<CR>
nnoremap <silent> <C-p> :<C-u>bp<CR>

inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>

nnoremap ; :
nnoremap : ;

nnoremap Y y$

vnoremap < <gv
vnoremap > >gv

" nnoremap p gP
" nnoremap P gp
" nnoremap gp P
" nnoremap gP p
" xnoremap p "_xgP
" xnoremap P "_xgp
" xnoremap gp "_xP
" xnoremap gP "_xp

" nnoremap x "_x
" nnoremap s "_s

noremap <C-h> 0
noremap <C-l> $

noremap <Left> <Nop>
noremap <Down> <Nop>
noremap <Up> <Nop>
noremap <Right> <Nop>

nnoremap + <C-a>
nnoremap - <C-x>
nnoremap <C-a> <Nop>
nnoremap <C-x> <Nop>


cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

" inoremap <C-j> <End><CR>
" inoremap <C-j><C-j> <Home><Down>

if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    " 置換モード時に非点滅の下線タイプのカーソル
    " let &t_SI .= "\e[6 q"
    " let &t_SI .= "\e[6 q"
    " let &t_EI .= "\e[2 q"
    let &t_SI .= "\e[5 q"
    let &t_EI .= "\e[1 q"
    let &t_SR .= "\e[3 q"
endif

" ヘルプ画面をqだけで閉じる
autocmd FileType help nnoremap <buffer> q <C-w>c

command! Indent2 :setlocal tabstop=2 shiftwidth=2 softtabstop=2
command! Indent4 :setlocal tabstop=4 shiftwidth=4 softtabstop=4
command! Indent8 :setlocal tabstop=8 shiftwidth=8 softtabstop=8

" -----------------------------------
" end basic part
" -----------------------------------
endif
