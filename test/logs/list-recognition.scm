(use-modules (srfi srfi-64)
             (orgfile)
             (sxml simple))

(test-begin "logs/list-recognition")

(test-equal "Parse ordered list"
  '(div (@ (class "")) (ol (li (p "Item 1")) (li (p "Item 2"))))
  (orgfile->sxml (parse-orgfile " 1. Item 1\n 2. Item 2")))

(test-equal "Parse unordered list with dash"
  '(div (@ (class "")) (ul (li (p "Item 1")) (li (p "Item 2"))))
  (orgfile->sxml (parse-orgfile " - Item 1\n - Item 2")))

(test-equal "Parse unordered list with plus"
  '(div (@ (class "")) (ul (li (p "Item 1")) (li (p "Item 2"))))
  (orgfile->sxml (parse-orgfile " + Item 1\n + Item 2")))

(test-end "logs/list-recognition")
