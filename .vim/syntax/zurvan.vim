
" Zurvan vim syntax file - see Zurvan.zvn

" Archive command
if !exists(":W")
	command W execute 'w|! ~/zvn/arc.pl < "'.expand("%:p").'" >> ~/zvn/'.strftime("%Y-%m-%d")
endif

function! GetTab()
	let tabs = ''
	let n = 0
	while n < &sw
		let n = n + 1
		let tabs = tabs.' '
	endwhile
	return tabs
endfunction

function! FoldText()
	let fold_line = getline(v:foldstart)
"	this doesn't work, have to use GetTab() instead :(
"	let fold_line = substitute(fold_line,'^\t','>\t','')
	let fold_line = substitute(fold_line,'\t',GetTab(),'g')
	let fold_line = substitute(fold_line,'^ ','>','')
	return fold_line
endfunction

function! FoldItem()

	let current_line = line(".")
	let count_tabs =  (strlen(getline(".")) - strlen(substitute(getline("."), "\t", "", "g"))) / strlen("\t")

	if search('^\t\{1,' . count_tabs . '}[-=+@%?!#] ', "W") > 0
		let found_line = line(".") - 1
		exe "normal k"
	else
		let found_line = line("$")
	endif

	exe current_line . "," . found_line . "fold"

endfun


map + za
map Ol za
map - :call FoldItem()<CR>
map OS :call FoldItem()<CR>
setlocal tabstop=3 shiftwidth=3
setlocal autoindent
setlocal fillchars=fold:\ 
"setlocal foldcolumn=1
setlocal foldtext=FoldText()
"setlocal foldtext=substitute(getline(v:foldstart),'\t','>\t','')

syn clear
syn case ignore
syn sync fromstart

"syn match zvnUrgent "^\t*[\-+@%?.] !"hs=e
syn region zvnInfo		start="^\t*#\s"	end="^\t*[-+@%?!#] "re=e-2 contains=ALL
syn region zvnPending	start="^\t*@\s"	end="^\t*[-+@%?!#] "re=e-2 contains=ALL
syn region zvnTodo		start="^\t*-\s"	end="^\t*[-+@%?!#] "re=e-2 contains=ALL
syn region zvnPriority	start="^\t*=\s"	end="^\t*[-+@%?!#] "re=e-2 contains=ALL
syn region zvnStarted	start="^\t*%\s"	end="^\t*[-+@%?!#] "re=e-2 contains=ALL
syn region zvnDone		start="^\t*+\s"	end="^\t*[-+@%?!#] "re=e-2 contains=ALL
syn region zvnMaybe		start="^\t*?\s"	end="^\t*[-+@%?!#] "re=e-2 contains=ALL
syn region zvnUrgent	start="^\t*!\s"	end="^\t*[-+@%?!#] "re=e-2 contains=ALL

" cterm colors:
"	black red green yellow blue magenta cyan white

" cterm types:	
"	none bold underline reverse
"	reverse = inverse italic standout
"	combined: underline,bold,reverse

" set foldcolumn=1

if !exists("did_zurvan_init")
	let did_zurvan_init = 1
"	colorscheme zurvan
	hi folded			ctermfg=254		ctermbg=237		cterm=none
	hi zvnInfo			ctermfg=254		ctermbg=none	cterm=none	
	hi zvnPending		ctermfg=117		ctermbg=none	cterm=none	
	hi zvnTodo			ctermfg=223		ctermbg=none	cterm=none	
	hi zvnStarted		ctermfg=229		ctermbg=none	cterm=none	
	hi zvnDone			ctermfg=85		ctermbg=none	cterm=none	
"	hi zvnIdea			ctermfg=147		ctermbg=none	cterm=none	
	hi zvnMaybe			ctermfg=248		ctermbg=none	cterm=none	
	hi zvnPriority		ctermfg=216		ctermbg=none	cterm=none
"	hi zvnUrgent		ctermfg=204		ctermbg=238		cterm=none	
	hi zvnUrgent		ctermfg=218		ctermbg=124		cterm=none	
endif

let b:current_syntax = "zurvan"

" vim:ts=4:sw=4
