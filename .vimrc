execute pathogen#infect()

syntax enable
syntax on
filetype plugin indent on
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
imap kj <Esc>
let mapleader = "\<Space>"

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
" set background=dark
set background=light
set nonumber
set relativenumber

set autowrite
set autoindent
set incsearch
set hlsearch
" set textwidth=80
" set colorcolumn=+1
highlight OverLength ctermbg=white guibg=#592929

" Support for infinite undo!
set undofile
set undodir=~/.vim/undodir
" Delete undo records over 90 days old
let s:undos = split(globpath(&undodir, '*'), "\n")
call filter(s:undos, 'getftime(v:val) < localtime() - (60 * 60 * 24 * 90)')
call map(s:undos, 'delete(v:val)')

" Use tab and shift-tab to cycle through tabs
nnoremap <Tab> :tabn<CR>
nnoremap <S-Tab> :tabp<CR>

" Special leader-based conveniences
nnoremap <Leader>o :tabf 
nnoremap <Leader>e :find 
nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cp :cprevious<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>ld :LspDefinition<CR>

" Custom commands
command! -complete=shellcmd -nargs=+ Sh new | 0read ! "<args>"

" for tablilne colors
hi TabLineFill term=bold cterm=bold ctermbg=0

" for custom statusline
" https://github.com/airblade/dotvim/blob/dd5d7737e39aad5e24c1a4a8c0d115ff2ae7b488/vimrc#L49-L91
hi clear StatusLine
hi clear StatusLineNC
hi clear SignColumn
hi LineNr ctermfg=grey
hi StatusLine   term=bold cterm=bold ctermfg=White
hi StatusLineNC term=bold cterm=bold ctermfg=White
hi User1                      ctermfg=4          guifg=#40ffff            " Identifier
hi User2                      ctermfg=2 gui=bold guifg=#ffff60            " Statement
hi User3 term=bold cterm=bold ctermfg=1          guifg=White   guibg=Red  " Error
hi User4                      ctermfg=1          guifg=Orange             " Special
hi User5                      ctermfg=10         guifg=#80a0ff            " Comment
hi User6 term=bold cterm=bold ctermfg=1          guifg=Red                " WarningMsg
set laststatus=2                                " always show statusline"
set statusline=
set statusline+=%6*%m%r%*                          " modified, readonly
set statusline+=\ 
set statusline+=%7*%{expand('%:h')}/               " relative path to file's directory
set statusline+=%5*%t%*                            " file name
set statusline+=\ 
set statusline+=\ 
set statusline+=%<                                 " truncate here if needed
set statusline+=%5*%L\ lines%*                     " number of lines

set statusline+=%=                                 " switch to RHS

set statusline+=%5*line:%-4.l%*                         " line
set statusline+=%5*col:%-3.c%*                          " column
set statusline+=\ 
set statusline+=\ 
set statusline+=%1*buf:%-3n%*                      " buffer number

" spellchecking in prose
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell
autocmd FileType gitcommit setlocal spell
set complete+=kspell
" linewrap in prose
" autocmd BufRead,BufNewFile *.md setlocal textwidth=80

" :help ale-options
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
" let g:ale_linters = {}
" let g:ale_linters['javascript'] = ['eslint']
" let g:ale_linters['ruby'] = ['rubocop']
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['ruby'] = ['rubocop']

" :help ale-options
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
" let g:ale_linters = {}
" let g:ale_linters['javascript'] = ['eslint']
" let g:ale_linters['ruby'] = ['rubocop']
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['ruby'] = ['rubocop']

" configuration for vim-lsp
if executable('solargraph')
    " gem install solargraph
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif
if executable('flow')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'flow',
        \ 'cmd': {server_info->['flow', 'lsp']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.flowconfig'))},
        \ 'whitelist': ['javascript', 'javascript.jsx'],
        \ })
endif

" :help syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_php_checkers = ["php"]
" let g:syntastic_css_checkers = ["csslint"]
" let g:syntastic_javascript_checkers = ["eslint"]
" let g:syntastic_ruby_checkers = ["rubocop"]
" let g:syntastic_aggregate_errors = 1
" JSX/React syntax
" let g:jsx_ext_required = 0

" autocompletion
set omnifunc=syntaxcomplete#Complete

" let :tabfind (:tabf) search in pwd, current file directory, recursive
set path=.,,**

" Display all matching files when we tab complete
set wildmenu

" FILE BROWSING:
" Tweaks for browsing:
let g:netrw_banner=0        " disable annoying banner
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_winsize=75      " sets the width to 75% of the page.
" let g:netrw_browse_split=2  " open files in a new vertical split

set foldmethod=manual
set nofoldenable        " disable folding

" Language specifics
autocmd FileType javascript match OverLength /\%81v.\+/
autocmd FileType ruby match OverLength /\%81v.\+/
autocmd FileType ruby set tabstop=8 shiftwidth=2
autocmd FileType php match OverLength /\%121v.\+/
autocmd FileType ruby match OverLength /\%81v.\+/
autocmd FileType ruby set tabstop=8 shiftwidth=2
autocmd FileType css set tabstop=8 shiftwidth=2
au BufRead,BufNewFile *.html.arb set filetype=ruby
au BufRead,BufNewFile *.go set filetype=go 
au BufRead,BufNewFile *.handler set filetype=javascript 

" :JsDoc
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1
let g:jsdoc_access_descriptions = 1
let g:jsdoc_underscore_private = 1
let g:jsdoc_enable_es6 = 1
nmap <C-l> :call jsdoc#insert()<CR>
" CompleteJS autocompletion
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
