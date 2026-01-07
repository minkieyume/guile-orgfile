(use-modules (srfi srfi-64)
             (orgfile)
             (sxml simple))

(test-begin "logs/headline-recognition")

(test-equal "Parse single level headline"
  '(div (@ (class "")) (h1 "A typical org file"))
  (orgfile->sxml (parse-orgfile "* A typical org file")))

(test-equal "Parse nested headlines"
  '(div (@ (class "")) (h1 "Level 1") (div (@ (class "")) (h2 "Level 2")))
  (orgfile->sxml (parse-orgfile "* Level 1\n** Level 2")))

(test-equal "Parse headline with tags"
  '(div (@ (class "")) (h1 "Headline with tags"))
  (orgfile->sxml (parse-orgfile "* Headline with tags :tag1:tag2:")))

(test-end "logs/headline-recognition")
