"Allow project specific .vimrc execution
syntax on

set exrc
set nobackup
set nowritebackup
set noswapfile
set nowrap
set hlsearch
set bs=2
set relativenumber
set belloff=all
set tabstop=4 softtabstop=0 expandtab shiftwidth=4
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set updatetime=500
set t_Co=256
set secure
set mouse=a
set wildmenu

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--info=inline', '--preview', 'bat --color=always {}']}, <bang>0)

filetype indent plugin on

map P "+gP
nnoremap <silent> <C-p> :Files<CR>

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


call plug#begin('~/.vim/plugged')
  Plug 'ryanoasis/vim-devicons'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'valloric/youcompleteme'

  Plug 'tpope/vim-dispatch'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'rrethy/vim-illuminate'
  Plug 'unblevable/quick-scope'
  Plug 'mhinz/vim-startify'
  Plug 'psliwka/vim-smoothie'
call plug#end()


if !has("gui_running")
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    set term=xterm
endif

set completeopt+=popup
set completepopup=height:10,width:60,highlight:Pmenu,border:off
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_show_diagnostics_ui = 0
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.','re![_a-zA-z0-9]'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::','re![_a-zA-Z0-9]'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'cs' : ['.','re![_a-zA-z0-9]'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }

" ========= airline settings start ======================

let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_detect_whitespace=0
let g:airline_powerline_fonts = 1
let g:airline_theme='tomorrow'

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#show_splits = 0

let g:airline_symbols = {}
let g:airline_symbols.linenr= ' '
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline_section_b = ''
let g:airline_section_c = ''
let g:airline_section_y = ''
let g:airline_section_z = '%#__accent_none#%{g:airline_symbols.linenr}%l%#__restore__#%#__accent_none#/%L'

" call airline#parts#define_accent('mode', 'none')

" ========= airline settings end ========================

" =================Color Scheme Start====================
hi clear

if exists("syntax on")
syntax reset
endif

set t_Co=256

" Define reusable colorvariables.
let s:white="#FFFFFF"
let s:bg="#282828"
let s:fg= "#BDAE93"
let s:fg2="#D5C4A1"
let s:fg3="#A89984"
let s:fg4="#A89984"
let s:bg2="#222222"
let s:bg3="#4a4a4a"
let s:bg4="#5c5c5c"
let s:cursorLinebg="#3C3836"
let s:cursorLinefg="#FABD2F"
let s:keyword="#e05c3a"
let s:builtin="#fe8019"
let s:const= "#bbaa97"
let s:comment="#7c6f64"
let s:func="#e9e0b2"
let s:str="#B8BB26"
let s:type="#66999d"
let s:var="#83a598"
let s:fieldName="#9ab8aa"
let s:className="#7298a3"
let s:warning="#ff6523"
let s:warning2="#ff2370"
let s:highlighted="#afff00"
let s:highlighted2='#5fffff'



"CS Highlight
let s:braces='#e9e0b2'
let s:modifier='#e05c3a'
let s:class='#7298a3'
let s:numbers='#8EC07C'

set cursorline
"set cursorlineopt=number

exe 'hi Normal guifg='s:fg' guibg='s:bg 
exe 'hi Visual  guibg='s:cursorLinebg
exe 'hi StringLiteral guifg='s:str
exe 'hi Cursor guifg='s:bg' guibg='s:fg 
exe 'hi Cursorline  guibg='s:cursorLinebg 
exe 'hi CursorColumn  guibg='s:bg2 
exe 'hi LineNr guifg='s:comment' guibg='s:bg 
exe 'hi CursorLineNr  guifg='s:cursorLinefg' guibg='s:cursorLinebg
exe 'hi VertSplit guifg='s:cursorLinebg' guibg='s:cursorLinebg 
exe 'hi MatchParen guifg='s:warning2'  gui=underline'
exe 'hi StatusLine guifg='s:fg2' guibg='s:bg3' gui=NONE'
exe 'hi Pmenu guifg='s:fg' guibg='s:bg2
exe 'hi PmenuSel  guibg='s:bg3 
exe 'hi IncSearch guifg='s:bg' guibg='s:keyword 
exe 'hi Search   gui=underline'
exe 'hi Directory guifg='s:const  
exe 'hi Folded guifg='s:fg4' guibg='s:bg 

exe 'hi Boolean guifg='s:const  
exe 'hi Character guifg='s:const  
exe 'hi Comment guifg='s:comment  
exe 'hi Conditional guifg='s:keyword  
exe 'hi Constant guifg='s:const  
exe 'hi Define guifg='s:keyword  
exe 'hi DiffAdd guifg=#f8f8f8 guibg=#46830c gui=NONE'
exe 'hi DiffDelete guifg=#ff0000'  
exe 'hi DiffChange guifg='s:fg' guibg='s:var 
exe 'hi DiffText guifg='s:fg' guibg='s:builtin' gui=NONE'
exe 'hi ErrorMsg guifg='s:warning' guibg='s:bg2' gui=NONE'
exe 'hi WarningMsg guifg='s:fg' guibg='s:warning2 
exe 'hi Float guifg='s:const  
exe 'hi Function guifg='s:func  
exe 'hi FieldName guifg='s:fieldName
exe 'hi ClassName guifg='s:className
exe 'hi Identifier guifg='s:type'  gui=NONE'
exe 'hi Keyword guifg='s:keyword'  gui=NONE'
exe 'hi Label guifg='s:var
exe 'hi NonText guifg='s:bg4' guibg='s:bg
exe 'hi Number guifg='s:const  
exe 'hi Operater guifg='s:keyword  
exe 'hi PreProc guifg='s:keyword  
exe 'hi Special guifg='s:fg  
exe 'hi SpecialKey guifg='s:fg2' guibg='s:bg2 
exe 'hi Statement guifg='s:keyword  
exe 'hi StorageClass guifg='s:type'  gui=italic'
exe 'hi String guifg='s:str  
exe 'hi Tag guifg='s:keyword  
exe 'hi Title guifg='s:fg'  gui=NONE'
exe 'hi Todo guifg='s:comment'  guibg='s:cursorLinebg'  gui=NONE'
exe 'hi Type guifg='s:type 
exe 'hi Underlined   gui=underline'

" Ruby Highlighting
exe 'hi rubyAttribute guifg='s:builtin
exe 'hi rubyLocalVariableOrMethod guifg='s:var
exe 'hi rubyGlobalVariable guifg='s:var' gui=italic'
exe 'hi rubyInstanceVariable guifg='s:var
exe 'hi rubyKeyword guifg='s:keyword
exe 'hi rubyKeywordAsMethod guifg='s:keyword' gui=NONE'
exe 'hi rubyClassDeclaration guifg='s:keyword' gui=NONE'
exe 'hi rubyClass guifg='s:keyword' gui=NONE'
exe 'hi rubyNumber guifg='s:const

" Python Highlighting
exe 'hi pythonBuiltinFunc guifg='s:builtin

" Go Highlighting
exe 'hi goBuiltins guifg='s:builtin

" Javascript Highlighting
exe 'hi jsBuiltins guifg='s:builtin
exe 'hi jsFunction guifg='s:keyword' gui=NONE'
exe 'hi jsGlobalObjects guifg='s:type
exe 'hi jsAssignmentExps guifg='s:var

" Html Highlighting
exe 'hi htmlLink guifg='s:var' gui=underline'
exe 'hi htmlStatement guifg='s:keyword
exe 'hi htmlSpecialTagName guifg='s:keyword

" Csharp Highlighting
exe 'hi csAttribute guifg='s:builtin
exe 'hi csLocalVariableOrMethod guifg='s:var
exe 'hi csGlobalVariable guifg='s:var' gui=italic'
exe 'hi csInstanceVariable guifg='s:var
exe 'hi csKeyword guifg='s:keyword
exe 'hi csKeywordAsMethod guifg='s:keyword' gui=NONE'
exe 'hi csClassDeclaration guifg='s:keyword' gui=NONE'
exe 'hi csClass guifg='s:class' gui=NONE'
exe 'hi csBraces guifg='s:braces' gui=NONE'
exe 'hi csParens guifg='s:braces' gui=NONE'
exe 'hi csModifier guifg='s:modifier' gui=NONE'
exe 'hi csNumber guifg='s:numbers

" Markdown Highlighting
exe 'hi mkdCode guifg='s:builtin

let g:OmniSharp_highlight_groups = {
\ 'Comment': 'NonText',
\ 'Keyword': 'Keyword',
\ 'Operator': 'Operater',
\ 'FieldName': 'FieldName',
\ 'ClassName': 'ClassName',
\ 'MethodName': 'Function',
\ 'PropertyName': 'Type',
\ 'PreprocessorKeyword': 'Keyword',
\ 'LocalName': 'Normal',
\ 'NamespaceName': 'Normal',
\ 'ParameterName': 'Normal',
\ 'XmlDocCommentName': 'Identifier',
\ 'XmlDocCommentText': 'NonText'
\}

exe 'hi QuickScopePrimary guifg='s:highlighted' gui=underline'
exe 'hi QuickScopeSecondary guifg='s:highlighted2' gui=underline'

" ==================Color Scheme End======================

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>