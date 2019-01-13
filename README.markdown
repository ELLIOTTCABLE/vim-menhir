vim-menhir
==========
This is my bad attempt at a Vim syntax-definition for `.mly` files — parser definitions for
[Menhir][] (or the built-in [`ocamlyacc`][]). It embeds whichever OCaml grammar you use for normal
`.ml` files into the appropriate sections of your parser-generators, as well; complex OCaml headers
and footers should be supported.

![](http://ell.io/iT9fn36+?.png)

As-yet unfinished work:

 - I want to properly highlight the syntax of actual nonterminal definitions. I have yet to get that
     far.

 - I need to support the [new syntax](https://sympa.inria.fr/sympa/arc/menhir/2018-11/msg00000.html)
     released in November 2018. It shouldn't be too hard, it shares a lot with the old `ocamlyacc`
     one.

I'm pretty involved with other projects, this may languish. Feel free to reach out at
[@ELLIOTTCABLE][], Freenode, or elsewhere, if you have any questions / I miss an Issue!

   [Menhir]: <http://gallium.inria.fr/~fpottier/menhir/> "An LR(1) parser-generator for OCaml"
   [`ocamlyacc`]: <http://caml.inria.fr/pub/docs/manual-ocaml/lexyacc.html#sec278>
   [@ELLIOTTCABLE]: <https://twitter.com/ELLIOTTCABLE> "ELLIOTTCABLE on Twitter"
