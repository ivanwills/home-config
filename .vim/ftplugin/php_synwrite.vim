" php_synwrite.vim : check syntax of PHP before writing
"
" Copied from perl_synwrite.vim. author : Ricardo Signes <rjbs-vim@public.manxome.org>

"" abort if b:did_php_synwrite is true: already loaded or user pref
if exists("b:did_php_synwrite")
	finish
endif
let b:did_php_synwrite = 1

"" execute the given do_command if the buffer is syntactically correct php
"" -- or if do_anyway is true
function! s:PHPSynDo(do_anyway,do_command)
	let command = "!php -l >/dev/null"

	" we need to cat here because :exec would add a space between ! and command
	" let to_exec = "write !" . command
	exec "write" command

	silent! cgetfile " try to read the error file
	if !v:shell_error || a:do_anyway
		exec a:do_command
		set nomod
	endif
endfunction

"" the :Write command
command -buffer -nargs=* -complete=file -range=% -bang Write call s:PHPSynDo("<bang>"=="!","<line1>,<line2>write<bang> <args>")
"autocmd BufWriteCmd,FileWriteCmd * call s:PHPSynDo(0,"write <afile>")
