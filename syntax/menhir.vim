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

syn keyword menhirDeclarationKeywordErr         %parameter %token %nonassoc %left %right %type
                                              \ %start %attribute %on_error_reduce
syn keyword menhirDeclarationKeyword contained  %parameter %token %nonassoc %left %right %type
                                              \ %start %attribute %on_error_reduce

syn keyword menhirRuleKeywordErr          %public %inline %prec
syn keyword menhirRuleKeyword contained   %public %inline %prec

syn keyword menhirDeclarationSeparator %%


syn cluster menhirEverywhere contains=menhir.*Comment,menhir.*KeywordErr,menhirDeclarationSeparator

" These break each document into the three sections of a Menhir parser definition:
" FIXME: Temporary approach, so I can iterate on the rest of this while I wait on my SO question:
"    <https://stackoverflow.com/q/54067397/31897>
syn cluster menhirDeclarations contains=menhirDeclarationKeyword
syn cluster menhirRules contains=menhirRuleKeyword
"syn region menhirSeparatorError start=/%%/ end=/%%/ contained contains=@menhirComments
syn region menhirOcamlFooter start=/OCAML/ end=/OCAMLEND/ contains=@menhirEverywhere
syn region menhirRules start=/RULES/ end=/RULESEND/ contains=@menhirEverywhere,@menhirRules
syn region menhirDeclarations start=/\%^/ end=/%%/lc=2 contains=@menhirEverywhere,@menhirDeclarations


hi default link menhirDeclarationKeyword     Keyword
hi default link menhirDeclarationKeywordErr  Error

hi default link menhirRuleKeyword            Keyword
hi default link menhirRuleKeywordErr         Error

hi default link menhirDeclarationSeparator   Special

hi default link menhirOcamlCommentErr        Error
hi default link menhirCCommentErr            Error
hi default link menhirOcamlComment           ocamlComment
hi default link menhirCComment               ocamlComment
hi default link menhirLineComment            ocamlComment


let b:current_syntax = "menhir"
