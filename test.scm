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

;; Parse the org document
(define doc (parse-orgfile org-text))
doc
;; doc:
;; (document ((__init . #f) (Custome . "custome") (AUTHOR . "Dreamtwi") (title . "Test Title") (__init . #t)) (section ((level . 1) (headline . "A typical org file") (tags "TAG1" "TAG2") (closed . #f)) (drawer ((name . "CUSTOM") (closed . #f)) (paragraph ((closed . #f)) (text ((closed . #t)) "another paragraph.")) (paragraph ((closed . #f)) (text ((closed . #t)) "|----+----+----+----|")) (paragraph ((closed . #f)) (text ((closed . #t)) "|iii |bbb | x  | zxs|")) (paragraph ((closed . #f)) (text ((closed . #t)) "|ele3|ele2|ele1|ele4|")) (paragraph ((closed . #f)) (text ((closed . #t)) "|ele1|ele2|ele3|ele4|")) (paragraph ((closed . #f)) (text ((closed . #t)) "|----+----+----+----|")) (paragraph ((closed . #f)) (text ((closed . #t)) "|list|lst1|lst2|lst3|")) (paragraph ((closed . #f)) (text ((closed . #t)) "|----+----+----+----|")) (paragraph ((closed . #f)) (text ((closed . #t)) "This is a list:")) (paragraph ((closed . #f)) (text ((closed . #t)) "This is a *important* word. /italic/ _underline_ =code= ~verbatim~ +delete+ . ")) (paragraph ((closed . #f)) (text ((closed . #t)) "#+end_src")) (paragraph ((closed . #f)) (text ((closed . #t)) "xxxxx")) (paragraph ((closed . #f)) (text ((closed . #t)) "#+begin_xxx xxxx xxxd xxxs")) (paragraph ((closed . #f)) (text ((closed . #t)) "#+end_src")) (paragraph ((closed . #f)) (text ((closed . #t)) "(display \"hello world\")")) (paragraph ((closed . #f)) (text ((closed . #t)) "#+begin_src scheme")) (paragraph ((closed . #f)) (text ((closed . #t)) "#+end_quote")) (paragraph ((closed . #f)) (text ((closed . #t)) "xxisjdiji")) (paragraph ((closed . #f)) (text ((closed . #t)) "#+begin_quote")) (list ((ordered . 2) (indent . 1)) (item ((indent . 1)) (paragraph ((closed . #f)) (text ((closed . #t)) "List item 2")))) (list ((ordered . 1) (indent . 1)) (item ((indent . 1)) (paragraph ((closed . #f)) (text ((closed . #t)) "List item 1")))) (paragraph ((closed . #f)) (text ((closed . #t)) ":arg1: test")) (paragraph ((closed . #f)) (text ((closed . #t)) ":header-args: :tangle src/main.rs")) (section ((level . 2) (headline . "Sections can be nested") (tags) (closed . #f))) (paragraph ((closed . #f)) (link ((url . "http://example.com") (description . "example link") (closed . #t))) (text ((closed . #t)) "a paragraph with an ")) (paragraph ((closed . #f)) (text ((closed . #t)) ":drawer2: test1 test2")) (paragraph ((closed . #f)) (text ((closed . #t)) ":drawer1: :hello src/hello.rs")))))

(define sxml (orgfile->sxml doc))
sxml
;; sxml:
;; ((div (@ (class "")) (h1 "A typical org file") (p "a paragraph with an " (a (@ (href "http://example.com")) "example link")) (div (@ (class "")) (h2 "Sections can be nested") (ol ((li ((p "List item 1"))) (li ((p "List item 2"))))) (p "another paragraph."))))

;; Convert the document to sxml and write to current output port
(sxml->xml sxml)

;; Output:
;; <div class=""><h1>A typical org file</h1><p>a paragraph with an <a href="http://example.com">example link</a></p><div class=""><h2>Sections can be nested</h2><ol><li><p>List item 1</p></li><li><p>List item 2</p></li></ol><p>another paragraph.</p></div></div>
