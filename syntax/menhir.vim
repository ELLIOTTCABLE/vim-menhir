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

syn keyword menhirDeclarationKeywordErr contained  %parameter %token %nonassoc %left %right %type
                                                 \ %start %attribute %on_error_reduce
syn keyword menhirDeclarationKeyword contained     %parameter %token %nonassoc %left %right %type
                                                 \ %start %attribute %on_error_reduce

syn region  menhirDeclarationTypeErr start=/</ end=/>/
syn region  menhirDeclarationType matchgroup=menhirDeclarationTypeBrack start=/</ end=/>/ contained
    \ contains=@ocamlRoot

syn region  menhirDeclarationOcamlHeaderErr matchgroup=menhirDeclarationOcamlBrackErr
    \ start=/%{/ end=/%}/
syn region  menhirDeclarationOcamlHeader matchgroup=menhirDeclarationOcamlBrack
    \ start=/%{/ end=/%}/ contained
    \ contains=@ocamlRoot

syn match   menhirDeclarationOcamlBrackErr "%}"

syn keyword menhirRuleKeywordErr contained   %public %inline %prec
syn keyword menhirRuleKeyword contained      %public %inline %prec

syn match   menhirRuleNonterminal contained     /[[:lower:]_][[:upper:][:lower:][:digit:]_]*/
syn match   menhirRuleTerminal contained        /[[:upper:]][[:upper:][:lower:][:digit:]_]*/
syn match   menhirRuleSemanticName contained    /[[:lower:]_][[:upper:][:lower:][:digit:]_]*/
syn match   menhirRuleSemanticBinding contained /[[:lower:]_][[:upper:][:lower:][:digit:]_]*\s*=/
    \ contains=menhirRuleSemanticName

" FIXME: This will break if comments are included in the params, i.e. `bleh(foo (*bar*), widget
"        (*baz*)):` — I need to turn `menhirRuleNonterminalDefinition` into a `:syn-region`.
syn match   menhirRuleNonterminalDefinitionName contained
    \ /[[:lower:]_][[:upper:][:lower:][:digit:]_]*/
syn match   menhirRuleNonterminalDefinitionParam contained
    \ /[[:upper:][:lower:]_][[:upper:][:lower:][:digit:]_]*/
syn region  menhirRuleNonterminalDefinitionParams contained
    \ start=/(/ end=/)/ contains=menhirRuleNonterminalDefinitionParam
syn match   menhirRuleNonterminalDefinition contained
    \ /[[:lower:]]\+\(([[:upper:][:lower:][:blank:],]\+)\)\?:/
    \ contains=menhirRuleNonterminalDefinitionName,menhirRuleNonterminalDefinitionParams

syn match   menhirOcamlLCIdentOverride  contained
    \ /[[:lower:]_][[:upper:][:lower:][:digit:]_]*/
syn region  menhirRuleSemanticAction contained
    \ matchgroup=menhirRuleSemanticActionBrace start=/{/ end=/}/
    \ contains=@ocamlRoot,menhirOcamlLCIdentOverride

syn keyword menhirDeclarationSeparator %%


syn cluster menhirEverywhere contains=menhir.*Comment.*,menhir.*KeywordErr,menhirDeclarationSeparator

" These break each document into the three sections of a Menhir parser definition:
" FIXME: Temporary approach, so I can iterate on the rest of this while I wait on my SO question:
"    <https://stackoverflow.com/q/54067397/31897>
syn cluster menhirDeclarations contains=menhirRule.*Err,menhirDeclarationKeyword,menhirDeclarationType,menhirDeclarationOcamlHeader
syn cluster menhirRules contains=menhirDeclaration.*Err,menhirRuleKeyword,menhirRuleNonterminal,menhirRuleTerminal,menhirRuleSemanticBinding,menhirRuleNonterminalDefinition,menhirRuleSemanticAction

syn region  menhirSeparatorError  start=/%%/ end=/\%$/ contained
    \ contains=@menhirComments
syn region  menhirOcamlFooter     start=/%%/ end=/%%/me=s-1 contained
    \ nextgroup=menhirSeparatorError contains=@menhirEverywhere,@ocamlRoot
syn region  menhirRules           start=/%%/ end=/%%/me=s-1 contained
    \ nextgroup=menhirOcamlFooter contains=@menhirEverywhere,@menhirRules
syn region  menhirDeclarations    start=/\%^./ end=/%%/me=s-1
    \ nextgroup=menhirRules contains=@menhirEverywhere,@menhirDeclarations


hi default link menhirDeclarationKeyword           Keyword
hi default link menhirDeclarationKeywordErr        Error
hi default link menhirDeclarationTypeErr           Error
hi default link menhirDeclarationOcamlHeaderErr    Error
hi default link menhirDeclarationOcamlBrack        Delimiter
hi default link menhirDeclarationOcamlBrackErr     Error


hi default link menhirRuleKeyword                  Keyword
hi default link menhirRuleKeywordErr               Error

hi default link menhirRuleNonterminalDefinitionName Function
hi default link menhirRuleNonterminalDefinitionParam Identifier

hi default link menhirRuleTerminal                 Character
hi default link menhirRuleNonterminal              String

hi default link menhirOcamlLCIdentOverride         PreProc
hi default link menhirRuleSemanticAction           PreProc
hi default link menhirRuleSemanticActionBrace      PreProc

hi default link menhirDeclarationSeparator         Special

hi default link menhirOcamlCommentErr              Error
hi default link menhirCCommentErr                  Error
hi default link menhirOcamlComment                 ocamlComment
hi default link menhirCComment                     ocamlComment
hi default link menhirLineComment                  ocamlComment

hi default link menhirSeparatorError               Error


let b:current_syntax = "menhir"
