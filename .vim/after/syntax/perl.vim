
" Defaults:
" unlet perl_include_pod
" unlet perl_want_scope_in_variables
" unlet perl_extended_vars
" unlet perl_string_as_statement
" unlet perl_no_sync_on_sub
" unlet perl_no_sync_on_global_var
" let perl_sync_dist = 100
" unlet perl_fold
" unlet perl_fold_blocks

syn region perlPOD start="^=[a-z]" end="^=cut" fold
set foldmethod=syntax

"hi Folded		term=standout ctermfg=44 ctermbg=30
"hi Statement	cterm=none ctermfg=223
"hi Comment		ctermfg=43
"hi link PerlStatement Comment
