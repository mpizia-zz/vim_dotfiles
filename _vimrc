"Allow project specific .vimrc execution
set exrc
filetype indent plugin on

"no backup files
set nobackup

nnoremap p "+gP

"only in case you don't want a backup file while editing
set nowritebackup

"no swap files
set noswapfile

" No wrapping
set nowrap

" Highlight search results when using /
set hlsearch

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=500

" all utf-8
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

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

" enable backspace...
set bs=2

"show line numbers
set relativenumber

" don't beep
set belloff=all

" 4 spaces indentation
set tabstop=4 softtabstop=0 expandtab shiftwidth=4

"Let's setup the plugins
call plug#begin('~/.vim/plugged')
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'ryanoasis/vim-devicons'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'OmniSharp/omnisharp-vim'

  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

  Plug 'tpope/vim-dispatch'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'rrethy/vim-illuminate'
  Plug 'unblevable/quick-scope'
  Plug 'mhinz/vim-startify'
call plug#end()

" CMDER SETTINGS
if !has("gui_running")
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
endif

map p "+gP

" Asyncomplete: {{{
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

silent! call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
    \ 'name': 'ultisnips',
    \ 'whitelist': ['*'],
    \ 'blacklist': [],
    \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
    \ }))

let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger="<nor>"
let g:ulti_expand_or_jump_res = 0
function! <SID>ExpandSnippetOrReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<C-Y>"
  endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"
let g:UltiSnipsJumpForwardTrigger="<tab>"                                       
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" ========= airline settings start ======================

let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_detect_whitespace=0

let g:airline_powerline_fonts = 1

" show branch information
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme='transparent'
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
call airline#parts#define_accent('mode', 'none')

let g:airline_section_b = ''
let g:airline_section_c = ''
let g:airline_section_y = ''
let g:airline_section_x = '%{airline#util#prepend("",0)}%{airline#util#prepend("",0)}%{airline#util#prepend("",0)}%{airline#util#prepend(airline#extensions#omnisharp#server_status(),0)}%{airline#util#prepend("",0)}'
let g:airline_section_z = '%#__accent_none#%{g:airline_symbols.linenr}%l%#__restore__#%#__accent_none#/%L'

" ========= airline settings end ========================

" =============== OmniSharp settings start===============
" OmniSharp won't work without this setting
filetype plugin on

" Use Roslyin and also better performance than HTTP
let g:OmniSharp_server_stdio = 1
let g:omnicomplete_fetch_full_documentation = 1
let g:OmniSharp_start_server = 1

" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 30

" this will make it so any subsequent C# files that you open are using the same solution and you aren't prompted again (so you better choose the right solution the first time around :) )
let g:OmniSharp_autoselect_existing_sln = 1

let g:OmniSharp_popup_options = {
\ 'padding': [1]
\}
autocmd CursorHold *.cs OmniSharpTypeLookup
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_selector_findusages = 'fzf'
let g:OmniSharp_highlighting = 3
let g:OmniSharp_diagnostic_listen = 0
let g:OmniSharp_want_snippet = 1

let g:OmniSharp_popup_mappings = {
\ 'sigNext': '<C-n>',
\ 'sigPrev': '<C-p>',
\ 'lineDown': ['<C-e>', 'j'],
\ 'lineUp': ['<C-y>', 'k']
\}
autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

nmap <space>o :OmniSharpStartServer<CR> :OmniSharpHighlight<CR>
" =============== OmniSharp settings end=================

" =================NERDTree settings start===============
" For more docos check out https://github.com/preservim/nerdtree/blob/master/doc/NERDTree.txt
let NERDTreeQuitOnOpen=1
let NERDTreeIgnore = ['\.meta$']
let NERDTreeNaturalSort=1
" Open new NERDTree instance bt typing nto
nmap nt :NERDTree<cr>
" Open existing NERDTree buffer (if any) at current tab
nmap ntm :NERDTreeMirror<cr>
" If you are using vim-plug, you'll also need to add these lines to avoid crashes when calling vim-plug functions while the cursor is on the NERDTree window
let g:plug_window = 'noautocmd vertical topleft new'
nmap <space>n :NERDTreeToggle<CR>

" =================NERDTree settings end=================

" fix colors
set t_Co=256

syntax on

"Disable unsafe commands since we are allowing project specific .vimrc file execution
set secure
set mouse=a

hi! CocErrorSign guifg=#d1666a

"Remaps
nnoremap <silent> <C-p> :Files<CR>

" =================Color Scheme Start=====================
hi clear

if exists("syntax on")
syntax reset
endif

set t_Co=256
"let g:colors_name = "darktooth"


" Define reusable colorvariables.
let s:white="#FFFFFF"
let s:bg="#282828"
let s:fg="#fdf4c1"
let s:fg2="#e9e0b2"
let s:fg3="#d5cda2"
let s:fg4="#c0b993"
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
exe 'hi Todo guifg='s:fg2'  gui=inverse,NONE'
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
exe 'hi csClass guifg='s:keyword' gui=NONE'
exe 'hi csNumber guifg='s:const


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