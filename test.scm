(use-modules (orgfile)
             (sxml simple))

(define org-text
  "#+title: Test Title
#+AUTHOR: Dreamtwi
#+Custome: custome
* A typical org file :TAG1:TAG2:
:CUSTOM:
:drawer1: :hello src/hello.rs
:drawer2: test1 test2
:END:

a paragraph with an [[http://example.com][example link]]

** Sections can be nested
:PROPERTIES:
:header-args: :tangle src/main.rs
:arg1: test
:END:
 1. List item 1
 2. List item 2

#+begin_quote
xxisjdiji
#+end_quote

#+begin_src scheme
(display \"hello world\")
#+end_src

#+begin_xxx xxxx xxxd xxxs
xxxxx
#+end_src

This is a *important* word. /italic/ _underline_ =code= ~verbatim~ +delete+ . 

This is a list:
|----+----+----+----|
|list|lst1|lst2|lst3|
|----+----+----+----|
|ele1|ele2|ele3|ele4|
|ele3|ele2|ele1|ele4|
|iii |bbb | x  | zxs|
|----+----+----+----|
 another paragraph.")

(define org-text-simple
"#+title: Test Title
#+AUTHOR: Dreamtwi
#+Custome: custome
* A typical org file :TAG1:TAG2:
:CUSTOM:
:drawer1: :hello src/hello.rs
:drawer2: test1 test2
:END:

a paragraph with an [[http://example.com][example link]]

** Sections can be nested
:PROPERTIES:
:header-args: :tangle src/main.rs
:arg1: test
:END:
 1. List item 1
 2. List item 2

 another paragraph.")

(define simple-doc (parse-orgfile org-text-simple))
(display "simple-doc=")
(newline)
(write simple-doc)
(newline)

;; Parse the org document
(define doc (parse-orgfile org-text))
(display "doc=")
(newline)
(write doc)
(newline)

(define sxml (orgfile->sxml doc))
(display "sxml=")
(newline)
(write sxml)
(newline)
;; sxml:
;; ((div (@ (class "")) (h1 "A typical org file") (p "a paragraph with an " (a (@ (href "http://example.com")) "example link")) (div (@ (class "")) (h2 "Sections can be nested") (ol ((li ((p "List item 1"))) (li ((p "List item 2"))))) (p "another paragraph."))))

;; Convert the document to sxml and write to current output port
(display "output=")
(newline)
(write (sxml->xml sxml))
(newline)

;; Output:
;; <div class=""><h1>A typical org file</h1><p>a paragraph with an <a href="http://example.com">example link</a></p><div class=""><h2>Sections can be nested</h2><ol><li><p>List item 1</p></li><li><p>List item 2</p></li></ol><p>another paragraph.</p></div></div>
