if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

call dein#add('Shougo/denite.nvim')
call dein#add('tpope/vim-fugitive')
call dein#add('thinca/vim-quickrun')
call dein#add('thinca/vim-ref')
call dein#add('yuratomo/w3m.vim')
call dein#add('vim-scripts/Align')
call dein#add('tpope/vim-surround')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('davidhalter/jedi-vim')
call dein#add('nvie/vim-flake8')
call dein#add('scrooloose/syntastic')
call dein#add('tyru/open-browser.vim')
call dein#add('kannokanno/previm')
call dein#add('dense-analysis/ale')
call dein#add('itchyny/lightline.vim')

" color schemes
call dein#add('altercation/vim-colors-solarized')
call dein#add('croaker/mustang-vim')
call dein#add('jeffreyiacono/vim-colors-wombat')
call dein#add('nanotech/jellybeans.vim')
call dein#add('vim-scripts/Lucius')
call dein#add('vim-scripts/Zenburn')
call dein#add('mrkn/mrkn256.vim')
call dein#add('jpo/vim-railscasts-theme')
call dein#add('therubymug/vim-pyte')
call dein#add('tomasr/molokai')

" game
call dein#add('katono/rogue.vim')
" google trans
call dein#add('daisuzu/translategoogle.vim')


call dein#end()

" その他インストールしていないものはこちらに入れる
if dein#check_install()
  call dein#install()
endif

" setting section
filetype plugin on
"colorscheme molokai
set number
set smartindent
set shiftwidth=2
set showmatch
set expandtab
set softtabstop=2
set tabstop=2
syntax on
set history=10000
set ignorecase
set hlsearch
set hidden
set smartcase
set cmdwinheight=15
" 畳み込みのマーカをセット。マーカは!で。
set fdm=marker commentstring=!%s
" crtl-n.or.pで次の（前の）ファイルに移動
nmap <C-n> :n<CR>
nmap <C-p> :N<CR>
cmap <C-f> <C-f>i
set directory=~/.vim/tmp
"tag setting
set tags=./tags,../tags/tags,../../tags,../../../tags

"最初から画面を縦分割
vsplit
set laststatus=2

" persistent undo
set undodir=./.vimundo,~/.vimundo
set undofile

" w3m key binding
nmap <expr> <C-k>1 ':W3m google    ' . expand('<cword>') .  ' <CR>'
nmap <expr> <C-k>2 ':W3m alc       ' . expand('<cword>') .  ' <CR>'
nmap <expr> <C-k>3 ':W3m python    ' . expand('<cword>') .  ' <CR>'
nmap <expr> <C-k>4 ':W3m wikipedia ' . expand('<cword>') .  ' <CR>'
nmap <expr> <C-k>5 ':W3m wikipedia_en ' . expand('<cword>') .  ' <CR>'
nmap <expr> <C-k>6 ':W3m yahoodict ' . expand('<cword>') .  ' <CR>'
nmap <expr> <C-k>7 ':W3m man       ' . expand('<cword>') .  ' <CR>'
nmap <expr> <C-k>8 ':W3m google tenki  <CR>'

" tag preview setting
nmap <expr> <F2> ':pts ' .expand('<cword>').  '<CR><CR> :ptj <CR>'

" 検索、置換でよく使うキーワード
cmap <C-k>1 \(.*\)
cmap <C-k>2 \%V
cmap <C-k>3 s/\%V\(.*\)\%V/"\1"/
cmap <C-k>4 s/\%V\([^ ]\{1,\}\)\%V/"\1"/

imap <F5> <ESC>:QuickRun <CR>i
nmap <F5> :QuickRun <CR>
let g:quickrun_config = {
\   "_" : {
\       "runner" : "vimproc",
\       "runner/vimproc/sleep" : 300,
\       "runner/vimproc/updatetime" : 100
\   },
\}

" colorscheme setting for diff
au FilterWritePre * if &diff | colorscheme evening | endif
if &diff
  colorscheme evening
endif

" 不可視文字を表示
set list
set listchars=tab:>-,trail:.

" markdowns
au BufRead,BufNewFile *.md set filetype=markdown

"" deoplete snippet
"let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets'

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=0 concealcursor=niv
endif

autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#auto_vim_configuration = 0
if !exists('g:deoplete#force_omni_input_patterns')
        let g:deoplete#force_omni_input_patterns = {}
endif

let g:deoplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

autocmd FileType python IndentGuidesEnable
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=darkgrey

" python autopep8
" original http://stackoverflow.com/questions/12374200/using-uncrustify-with-vim/15513829#15513829
function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

function! Autopep8()
    call Preserve(':silent %!autopep8 - --max-line-length 120')
endfunction

" Shift + F で自動修正
autocmd FileType python nnoremap <S-f> :call Autopep8()<CR>
" " markdown lint
" let g:ale_sign_error                  = '✘'
" let g:ale_sign_warning                = '⚠'
" highlight ALEErrorSign ctermbg        =NONE ctermfg=red
" highlight ALEWarningSign ctermbg      =NONE ctermfg=yellow
" let g:ale_linters_explicit            = 1
" let g:ale_lint_on_text_changed        = 'never'
" let g:ale_lint_on_enter               = 0
" let g:ale_lint_on_save                = 1
" let g:ale_fix_on_save                 = 1
"
" let g:ale_linters = {
" \   'markdown':      ['mdl', 'writegood'],
" \}
"
" let g:ale_fixers = {
" \   '*':          ['remove_trailing_lines', 'trim_whitespace'],
" \}

" previm setting
let g:previm_enable_realtime = 0

" google trans
let g:translategoogle_default_sl = 'ja'
let g:translategoogle_default_tl = 'en'

" char code
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
