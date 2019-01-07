if exists("b:current_syntax")
    finish
endif

syn include ocamlRoot syntax/ocaml.vim

" I much prefer Steve Losh's viewpoint on using Vim command-abbreviation in Vimscripts (see
" <http://ell.io/-vimshorts>); but a brief survey of Vim syntaxfiles out there shows that *basically
" eveyone* abbreviates `syn` and `hi`. Well, when in Rome ...

syn case ignore

" This is the `:syn-iskeyword` documentation's default value, covering “all alphabetic characters,
" plus the numeric characters, all accented characters,” plus `_` and `%`.
syn iskeyword @,48-57,192-255,%,_


syn region  menhirOcamlComment start="(\*" end="\*)" contains=@Spell,menhirOcamlComment,ocamlTodo
syn region  menhirCComment start="/\*" end="\*/" contains=@Spell,ocamlTodo
syn match   menhirLineComment excludenl "//.*$" contains=@Spell,ocamlTodo

syn match   menhirOcamlCommentErr "\*)"
syn match   menhirCCommentErr "\*/"


syn cluster menhirComments contains=menhir.*Comment



syn keyword menhirKeyword              %parameter %token %nonassoc %left %right %type %start
                                     \ %attribute %on_error_reduce %public %inline %prec
syn keyword menhirDeclarationSeparator %%

syn region menhirDeclarations start=/\%^/ end=/%%/ contains=@menhirComments


hi default link menhirKeyword                Keyword
hi default link menhirDeclarationSeparator   Special

hi default link menhirOcamlCommentErr        Error
hi default link menhirCCommentErr            Error
hi default link menhirOcamlComment           ocamlComment
hi default link menhirCComment               ocamlComment
hi default link menhirLineComment            ocamlComment

hi menhirDeclarations guibg=white

let b:current_syntax = "menhir"
