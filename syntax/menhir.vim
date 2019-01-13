if exists("b:current_syntax")
    finish
endif

syn include @ocamlRoot syntax/ocaml.vim

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

syn region  menhirDeclarationTypeErr matchgroup=menhirDeclarationTypeBrack start=/</ end=/>/
syn region  menhirDeclarationType matchgroup=menhirDeclarationTypeBrack start=/</ end=/>/ contained
    \ contains=@ocamlRoot

syn region  menhirDeclarationOcamlHeaderErr matchgroup=menhirDeclarationTypeBrack
    \ start=/%{/ end=/%}/
syn region  menhirDeclarationOcamlHeader matchgroup=menhirDeclarationTypeBrack
    \ start=/%{/ end=/%}/ contained
    \ contains=@ocamlRoot

syn keyword menhirRuleKeywordErr          %public %inline %prec
syn keyword menhirRuleKeyword contained   %public %inline %prec

syn region  menhirRuleAction matchgroup=menhirRuleActionBrace start=/{/ end=/}/ contained
    \ contains=@ocamlRoot

syn keyword menhirDeclarationSeparator %%


syn cluster menhirEverywhere contains=menhir.*Comment,menhir.*KeywordErr,menhirDeclarationSeparator

" These break each document into the three sections of a Menhir parser definition:
" FIXME: Temporary approach, so I can iterate on the rest of this while I wait on my SO question:
"    <https://stackoverflow.com/q/54067397/31897>
syn cluster menhirDeclarations contains=menhirDeclarationKeyword,menhirDeclarationType,menhirDeclarationOcamlHeader
syn cluster menhirRules contains=menhirRuleKeyword,menhirRuleAction

syn region  menhirSeparatorError  start=/%%/ end=/\%$/ contained
    \ contains=@menhirComments
syn region  menhirOcamlFooter     start=/%%/ end=/%%/me=s-1 contained
    \ nextgroup=menhirSeparatorError contains=@menhirEverywhere,@ocamlRoot
syn region  menhirRules           start=/%%/ end=/%%/me=s-1 contained
    \ nextgroup=menhirOcamlFooter contains=@menhirEverywhere,@menhirRules
syn region  menhirDeclarations    start=/\%^./ end=/%%/me=s-1
    \ nextgroup=menhirRules contains=@menhirEverywhere,@menhirDeclarations


hi default link menhirDeclarationKeyword     Keyword
hi default link menhirDeclarationKeywordErr  Error
hi default link menhirDeclarationTypeErr     Error
hi default link menhirDeclarationOcamlHeaderErr Error

hi default link menhirRuleKeyword            Keyword
hi default link menhirRuleKeywordErr         Error
hi default link menhirRuleActionBrace        Delimiter

hi default link menhirDeclarationSeparator   Special

hi default link menhirOcamlCommentErr        Error
hi default link menhirCCommentErr            Error
hi default link menhirOcamlComment           ocamlComment
hi default link menhirCComment               ocamlComment
hi default link menhirLineComment            ocamlComment

hi default link menhirSeparatorError         Error

let b:current_syntax = "menhir"
