" Vim syntax file

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
	finish
endif
runtime! syntax/html.vim

if filereadable($VIMRUNTIME."/syntax/perl.vim")
	unlet! b:current_syntax
	syn include @ptPerlScript $VIMRUNTIME/syntax/perl.vim
	syn region ptPerlRegion matchgroup=htmlTag start="\[+" end="+\]" contains=@ptPerlScript
	syn region ptPerlRegion matchgroup=htmlTag start="\[-" end="-\]" contains=@ptPerlScript
endif

let b:current_syntax= "pt"

" vim: ts=8

