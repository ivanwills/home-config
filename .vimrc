" Setup
" cd ~/.vim
" git submodule update --init
"  $ vim +BundleInstall +qall
"
"set term=xterm-putty
set term=linux
set t_Co=256
set ttymouse=xterm mouse=a
set encoding=utf-8 fileencodings=

" vundle Bundles
" Docs @ https://github.com/gmarik/vundle
"
" to install new bundles:
"  $ vim +BundleInstall +qall
"
" vundle base configuration
set nocompatible            " vim default
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" My Bundles
"
" Script debuggers
"Bundle 'joonty/vdebug.git'
"Bundle 'scrooloose/syntastic.git'
Bundle 'w0rp/ale'
Bundle 'mannih/vim-perl-variable-highlighter.git'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'benmills/vimux'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'gabrielelana/vim-markdown'
Bundle 'bling/vim-airline'
"Bundle 'ryanoasis/vim-devicons'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'bogado/file-line'
Bundle 'vim-perl/vim-perl'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
Bundle 'c9s/perlomni.vim'
Bundle 'hotchpotch/perldoc-vim'
Bundle 'pangloss/vim-javascript'
Bundle 'mxw/vim-jsx'
Bundle 'othree/javascript-libraries-syntax.vim'
Bundle 'isruslan/vim-es6'
Bundle 'elzr/vim-json'

" Back to normal processing
filetype plugin indent on

"call pathogen#infect()

" spare maps:  

" visual shifting
vnoremap < <gv
vnoremap > >gv

" WORD MOTION
" Move to left to start of next word <C-<left>>
 map O5D <S-Left>
imap O5D <S-Left>
 map O1;5D <S-Left>
imap O1;5D <S-Left>
 map [1;5D <S-Left>
imap [1;5D <S-Left>
" Move right to start of next word <C-<right>>
 map O5C <S-Right>
imap O5C <S-Right>
 map O1;5C <S-Right>
imap O1;5C <S-Right>
 map [1;5C <S-Right>
imap [1;5C <S-Right>
 map [5D <S-Left>
imap [5D <S-Left>
 map [5C <S-Right>
imap [5C <S-Right>

" VERTICAL MOTION
imap O5A <C-O>7k
 map O5A 7k
imap O5B <C-O>7j
 map O5B 7j
imap [5A <C-O>7k
 map [5A 7k
imap [5B <C-O>7j
 map [5B 7j
imap O1;5A <C-O>7k
 map O1;5A 7k
imap O1;5B <C-O>7j
 map O1;5B 7j
imap [1;5A <C-O>7k
 map [1;5A 7k
imap [1;5B <C-O>7j
 map [1;5B 7j
imap <C-Up> <C-O>7k
 map <C-Up> 7k
imap <C-Down> <C-O>7j
 map <C-Down> 7j

" Some conflicts exist with key stroaks TMUX vs SCREEN
if empty($TMUX)
    " SCREEN MOTION
    imap OA <C-X><C-E>
     map OA <C-E>
    imap OB <C-X><C-Y>
     map OB <C-Y>
    imap O3A <C-X><C-E>
     map O3A <C-E>
    imap O3B <C-X><C-Y>
     map O3B <C-Y>
else
    " tmux
    imap OA <C-O>7k
     map OA 7k
    imap OB <C-O>7j
     map OB 7j
endif

" Buffer Size
" Increase buffer size alt+up arrow
imap [1;3A <C-X>7<C-w>+
 map [1;3A 7<C-w>+
imap [1;4A <C-X>200<C-w>+
 map [1;4A 200<C-w>+
" Decrease buffer size alt+down arrow
imap [1;3B <C-X>7<C-w>-
 map [1;3B 7<C-w>-
imap [1;4B <C-X>200<C-w>-
 map [1;4B 200<C-w>-

" Speed movements
" Default key mappings
imap <C-j> <C-O>7j
imap <C-l> <C-O>w
imap <C-k> <C-O>7k
imap <C-h> <C-O>b
 map <C-j> 7j
 map <C-l> w
 map <C-k> 7k
 map <C-h> b

" NAVIGATION
" Move to beginning of line <home>
 map <Home> gg
imap <Home> <C-O>gg
 map OH <Home>
imap OH <Home>
" Move to end of line <end>
 map <End> G
imap <End> <C-O>G
 map OF <End>
imap OF <End>
" Move to beginning of document <S-<up>>
 map 02A gg
imap 02A <C-O>gg
" Move to end of document <S-<down>>
 map 02B G
imap 02B <C-O>G


" edit buffers
 map bn :bn<CR>
 map bp :bp<CR>
 map bl :ls<CR>
 map  :ls<CR>
imap  <C-O>:ls<CR>

" stops deleting to buffer
 map <Backspace> "_X
vmap <Backspace> "_x
 map <Del> "_x

" save current file
" map  :w<CR>:echo "Saved"<CR>
" map <C-W> :w<CR>:echo "Saved"<CR>
 map <C-X> :q<CR>

" save all buffers
 map / :wa<CR>:echo "All Buffers Saved."<CR>
imap / <Esc>:wa<CR>:echo "All Buffers Saved."<CR>

" quit all
 map \ :qa<CR>
imap \ <Esc>:qa<CR>

" delete line
imap <C-L> <C-O>dd
" undo edit
imap <C-Z> <C-O>u
" folding
 map + za

" increase/decrease buffer height
 map = <C-w>+
 map - <C-w>-

" Syntax checking for perl/php

" datetime stamp
iab dts <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>

" status line
set statusline=%F%m%r%h%w\ Format:%{&ff}\ Type:%Y\ ASCII=\%03.3b\ HEX=\%02.2B\ %=%l,%v\ %p%%\ /\ %L
" ◀▶⫷⫸⮘⮚⮜⮞𝆒𝆓🐪🐧🞀🞂
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
"let g:airline_section_b = '%{getcwd()}/%t'
"let g:airline_left_sep='❯'
"let g:airline_right_sep='❮'
"let g:airline_left_sep='▶'
"let g:airline_right_sep='◀'
"let g:airline_theme=

set list
set listchars=tab:»·,trail:·,extends:>,precedes:<

syntax on
filetype on

set wildmode=longest,list	" Show list of files when completing
set autoindent				" next line matches line above
"set cindent                 " C-Style indenting
set cinkeys=0{,0},0),!^F,o,O,e
set cinoptions=>s,e0,n0,f0,{0,}0,^0,:s,=s,l1,b0,gs,hs,ps,ts,is,+s,c3,C0,/0,(s,us,U1,w0,W4,m0,j0,)20,*50,#1
set laststatus=2			" always displays the ruler
set visualbell				" visual bell
set timeoutlen=123			" timeout for maps
set fileformat=unix
set hidden					" allows switching buffers without saving
set backspace=2				" backspacing deletes everything in insert mode
set background=dark			" background (light/dark)

set textwidth=160           " set the text width for those times that vim ignores nowrap
set nowrap					" wordwrap off
set showmode				" show mode below status line.
set showcmd					" show (partial) command in status line.
set showmatch				" show matching brackets.
set ruler					" show the line and column numbers of the cursor
set ignorecase				" case insensitive matching
set smartcase				" Match case when some upper case is used

set hlsearch				" highlight searched strings
set incsearch				" BUT do highlight as the search string is typed

set splitbelow				" new split window below the current one
set splitright				" new split window to the right of the current one

set vop=folds,cursor		" do not save options with views

"" Enable backups of edited files
"set backup
"set backupdir=~/.vim/backup
"set patchmode=.orig

set so=5

":set runtimepath=~/.vim,/opt/share/vim,$VIMRUNTIME
runtime menu.vim
set wildmenu
set wcm=<C-Z>
set cpo-=<

" tabs settings
set shiftwidth=4 tabstop=4
"set noexpandtab " real tabs
set expandtab

" switch tabs
function! SetTabSize()
	if &tabstop == "2"
		set tabstop=4
		set shiftwidth=4
		echo "Tab=4"
	elseif &tabstop == "4"
		set tabstop=8
		set shiftwidth=8
		echo "Tab=8"
	else
		set tabstop=2
		set shiftwidth=2
		echo "Tab=2"
	endif
endfunction

function ToggleHLSearch()
	if &hls
		set nohls
	else
		set hls
	endif
endfunction

" quick settings
 map t :call SetTabSize()<CR>
 map   :call SetTabSize()<CR>
nmap <silent> <C-n> <Esc>:call ToggleHLSearch()<CR>
 map h :set nohls!<CR>:set nohls?<CR>
 map   :set nohls!<CR>:set nohls?<CR>
 map i :set noai!<CR>:set noai?<CR>
 map l :set nolist!<CR>:set nolist?<CR>
 map   :set nolist!<CR>:set nolist?<CR>
 map p :set nospell!<CR>:set nospell?<CR>
 map   :set nospell!<CR>:set nospell?<CR>
 map o :set nopaste!<CR>:set nopaste?<CR>
 map   :set nopaste!<CR>:set nopaste?<CR>
"imap x <C-X>:set nopaste!<CR>:set nopaste?<CR>
"imap   <C-X>:set nopaste!<CR>:set nopaste?<CR>
"map r :set readonly!<CR>

if has("autocmd")
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on
    " ...

    " Autocompletion
    if has("autocmd") && exists("+omnifunc")
        autocmd Filetype *
        \ if &omnifunc == "" |
        \ setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
    endif

    " set syntax for notes/work
    autocmd BufRead  *.zvn set syntax=zurvan | loadview
    autocmd BufWrite *.zvn mkview

    " delete trailing DOS returns & whitespace
    " This version does not flag the file as being modified
    autocmd BufRead * silent! %s/[\r \t]\+$//
    " This version only affects php files but does leave maked as modified
    "autocmd BufEnter *.php  silent! :%s/[ \t\r]\+$//e
    "autocmd BufWritePre *.gz set bin

    " special perl syntax
    " autocmd BufRead *.html set syntax=pt

    autocmd BufRead /etc/* set tabstop=8 shiftwidth=8
    autocmd BufRead /var/named/* set tabstop=8 shiftwidth=8
    autocmd BufRead /www/conf/* set tabstop=8 shiftwidth=8
    autocmd BufRead /tmp/crontab* set tabstop=8 shiftwidth=8
    autocmd BufRead *.pl,*.pm,*.pl.ttk,*.pm.ttk,*.cgi,*.t,*.t.ttk,*.tt,*.tt2 set tabstop=4 shiftwidth=4 filetype=perl
    autocmd BufRead *.pl,*.pm,*.pl.ttk,*.pm.ttk,*.cgi,*.t,*.t.ttk compiler perl
    autocmd BufRead /tmp/psql.edit.* set filetype=sql syntax=sql tabstop=4 shiftwidth=4
    autocmd BufRead *.html.tmpl,*.html.ttk,*.vm,*.ftl set syntax=html
    autocmd BufRead *.tt,*.tt2 set syntax=tt2
    autocmd BufRead *.js.tmpl,*.js.ttk,*.js.tt2 set syntax=javascript filetype=javascript
    autocmd BufRead *.css.tmpl,*.css.ttk,*.css.tt2 set syntax=css
    autocmd BufRead *.ics set syntax=icalendar
    autocmd BufRead *.pkg,*.lib set filetype=PHP syntax=php textwidth=300 noexpandtab
    autocmd BufRead *.php,*.lib,*.pkg set iskeyword=@,48-57,_ noexpandtab
    autocmd BufRead *.php,*.lib,*.pkg map <S-e> :EnableFastPHPFolds<cr>
    autocmd BufRead *.t set filetype=perl
    autocmd BufRead *.cfg.* set filetype=cfg
    autocmd BufRead *.css set nocin
    autocmd BufRead *.sql,*.psql set expandtab filetype=sql syntax=sql
    autocmd BufRead *.ftl set syntax=ftl
    autocmd BufRead *.vm set syntax=velocity
    autocmd BufRead *.yml,*.yaml set shiftwidth=2 tabstop=2

    " Optus stuff
    autocmd BufRead *.zoo set expandtab filetype=javascript
    autocmd BufRead /home/dev/1P/* set noexpandtab
    autocmd BufRead /home/ivan/1P/* set noexpandtab

    autocmd FileType php noremap <C-L> :!/usr/bin/php -l %<CR>

    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline

    "autocmd BufWinEnter * let w:m1=matchadd('WarnCol', '\%<160v.\%>120v', -1)
    "autocmd BufWinEnter * let w:m2=matchadd('ErrorCol', '\%>160v.\+', -1)
    "autocmd BufWinEnter *.pl,*.pm,*.pod,*.js,*.t,*.php,*.lib let w:m1=matchadd('WarnCol', '\%<81v.\%>76v', -1)
    "autocmd BufWinEnter *.pl,*.pm,*.pod,*.js,*.t,*.php,*.lib let w:m2=matchadd('ErrorCol', '\%>80v.\+', -1)
    "autocmd BufWinEnter *.js,*.feature,*.scss let w:m1=matchadd('WarnCol', '\%<120v.\%>81v', -1)
    autocmd BufWinEnter *.js,*.feature,*.scss let w:m2=matchadd('ErrorCol', '\%>120v.\+', -1)
    autocmd BufWinEnter *.json setlocal foldmethod=syntax
    autocmd BufWinEnter *.json set shiftwidth=2 tabstop=2

    " templates
    autocmd BufNewFile * silent! Or ~/.vim/templates/%:e.template
endif

colorscheme cameo
set cursorline
"colorscheme default

" Ivan Modifications
 map <tab> <c-w>w
 map <s-tab> <c-w>W
 map ) :bnext!<CR>
 map ( :bprevious!<CR>
 " Run the macro called q, got via:
 "  qq (macro actions) q
 map - @q
 map = @w

 map <C-s> :w<cr>
 map <S-w> :WMToggle<CR>
 map <S-t> :TlistToggle<CR>
 map <S-e> :%foldclose<CR>

" ASCII Art Boxes program integeration
vmap ,mc !boxes -d c-cmt<CR>
nmap ,mc !!boxes -d c-cmt<CR>

" Spell checking
if version >= 700
	setlocal spell spelllang=en_au
endif

" Abbreviations
ab jumboaffilaites jumboaffiliates
ab affilaites affiliates
ab teh the
ab hte the
ab colsole console
ab DDD use Data::Dumper qw/Dumper/;
ab CCC use Carp qw/carp croak cluck confess longmess/;
ab IVANT global $IVAN_TEST;<CR>if (isset($IVAN_TEST)) print
ab ccc if (console && isDef(typeof console.log) && isFunc(console.log)) console.log('');
ab mooargs around BUILDARGS => sub {    my ($orig, $class, @args) = @_;my $args	= !@args     ? {}: @args == 1 ? $args[0]:              {@args};warn __PACKAGE__ . ' : ', Dumper $args;return $class->$orig($args);};

nmap ,s :source ~/.vimrc
nmap ,v :e ~/.vimrc

" Window Manager Alterations

let g:winManagerWindowLayout = "BufExplorer|TagsExplorer,FileExplorer"

" Perl Hacks ...
"
" quick help
"set keywordprog=perldoc\ -f

" auto completions ...

if has("autocmd")
    autocmd BufRead *.pl,*.pm   set iskeyword+=:,_
    autocmd BufRead *.js,*.json set iskeyword+=_

endif

" #7 Tidy
map ,pt  <Esc>:%! perltidy<CR>
map ,ptv <Esc>:'<,'>! perltidy<CR>

silent call system("perl -e0 -MVi::QuickFix")
let perl_synwrite_qf = ! v:shell_error

" using the perl hightliter
let perl_fold=1
let perl_fold_blocks = 1

let javaScript_fold=1

au BufWinLeave * mkview
au BufWinEnter * silent loadview
set foldmethod=indent

" quickfix for Perl error formats
set errorformat+=%m\ at\ %f\ line\ %l\.
set errorformat+=%m\ at\ %f\ line\ %l
" see https://gist.github.com/3142826#file_gistfile1.pl
noremap ,c :!time perlc --critic %<cr>
noremap c :!time perlc --critic %<cr>

try
    " Save undo's after file closes
    set undofile
    " where to save undo histories
    set undodir=/tmp/.$USER
    " How many undos
    set undolevels=1000
    " number of lines to save for undo
    set undoreload=10000
catch
    try
        " Save undo's after file closes
        set undofile
        " where to save undo histories
        set undodir=$HOME/.undo-vim
        " create the dir if missing
        call system('mkdir -p ' . &undodir)
        " How many undos
        set undolevels=1000
        " number of lines to save for undo
        set undoreload=10000
    catch
    endtry
endtry

" Macros
"  Split into 2 rows
let @a=':sp)	:q		'
"  Split into 3 rows
let @b=':sp):sp)		:q:q			'
"  Split into 4 rows
let @c=':sp):sp):sp)			:q:q:q				'
"  Split into 5 rows
let @d=':sp):sp):sp):sp)				:q:q:q:q					'

set foldlevel=3

let g:ale_sh_shellcheck_executable = "shellcheck -x"
