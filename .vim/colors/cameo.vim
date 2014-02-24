" Vim color file
" Maintainer: Xavier Bergade <xBergade@hotmail.com>
" Last Change: 2005-05-05

hi clear
set background=dark

if exists("syntax_on")
	syntax reset
endif

hi Normal	guifg=#F0FFF0	guibg=#006000
hi Folded	term=standout	ctermfg=44	ctermbg=30
hi Comment	term=none	ctermfg=43
hi Identifier	term=none	ctermfg=81	cterm=none
hi Constant	term=none	ctermfg=223
hi Statement	term=none	ctermfg=216
hi Type		term=none	ctermfg=110
hi Preproc	term=none	ctermfg=117

hi DiffText	term=reverse	ctermbg=163	ctermfg=254	cterm=none
hi DiffChange	term=bold	ctermbg=131
hi DiffDelete	term=bold	ctermbg=67	ctermfg=56
hi DiffAdd	term=bold	ctermbg=67	ctermfg=253

hi CursorLine	term=none	ctermbg=28	cterm=none

hi WarnCol      ctermbg=22
hi ErrorCol     ctermbg=52
hi HiLight0     ctermbg=60
hi HiLight1     ctermbg=61
hi HiLight2     ctermbg=62
hi HiLight3     ctermbg=63
hi HiLight4     ctermbg=64
hi HiLight5     ctermbg=65
hi HiLight6     ctermbg=66
hi HiLight7     ctermbg=67
hi HiLight8     ctermbg=68
hi HiLight9     ctermbg=69
" vim: ts=8
