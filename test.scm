(use-modules (orgfile)
             (sxml simple))

(define org-text
  "* A typical org file :TAG1:TAG2:

a paragraph with an [[http://example.com][example link]]

** Sections can be nested

 1. List item 1
 2. List item 2
 
 
 another paragraph.")

;; Parse the org document
(define doc (parse-orgfile org-text))
doc
;; doc:
;; (document ((__init . #f) (__init . #t)) (section ((level . 1) (headline . "A typical org file") (tags) (closed . #f)) (section ((level . 2) (headline . "Sections can be nested") (tags) (closed . #f)) (paragraph ((closed . #f)) (text ((closed . #t)) "another paragraph.")) (list ((closed . #t) (last-line-empty . #t) (ordered . 1) (indent . 1)) (item ((indent . 1)) (paragraph ((closed . #f)) (text ((closed . #t)) "List item 2"))) (item ((indent . 1)) (paragraph ((closed . #f)) (text ((closed . #t)) "List item 1"))))) (paragraph ((closed . #t) (closed . #f)) (link ((url . "http://example.com") (description . "example link") (closed . #t))) (text ((closed . #t)) "a paragraph with an "))))

(define sxml (orgfile->sxml doc))
sxml
;; sxml:
;; ((div (@ (class "")) (h1 "A typical org file") (p "a paragraph with an " (a (@ (href "http://example.com")) "example link")) (div (@ (class "")) (h2 "Sections can be nested") (ol ((li ((p "List item 1"))) (li ((p "List item 2"))))) (p "another paragraph."))))

;; Convert the document to sxml and write to current output port
(sxml->xml sxml)

;; Output:
;; <div class=""><h1>A typical org file</h1><p>a paragraph with an <a href="http://example.com">example link</a></p><div class=""><h2>Sections can be nested</h2><ol><li><p>List item 1</p></li><li><p>List item 2</p></li></ol><p>another paragraph.</p></div></div>
