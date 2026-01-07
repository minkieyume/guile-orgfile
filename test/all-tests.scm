(use-modules (srfi srfi-64)
             (orgfile)
             (sxml simple))

(test-begin "logs/orgfile-tests")

(test-group "list-recognition"
  (test-equal "Parse ordered list"
    '(div (@ (class "")) (ol (li (p "Item 1")) (li (p "Item 2"))))
    (orgfile->sxml (parse-orgfile " 1. Item 1\n 2. Item 2")))

  (test-equal "Parse unordered list with dash"
    '(div (@ (class "")) (ul (li (p "Item 1")) (li (p "Item 2"))))
    (orgfile->sxml (parse-orgfile " - Item 1\n - Item 2")))

  (test-equal "Parse unordered list with plus"
    '(div (@ (class "")) (ul (li (p "Item 1")) (li (p "Item 2"))))
    (orgfile->sxml (parse-orgfile " + Item 1\n + Item 2"))))

(test-group "link-recognition"
  (test-equal "Parse link in paragraph"
    '(div (@ (class "")) (p (a (@ (href "http://example.com")) "example link")))
    (orgfile->sxml (parse-orgfile "[[http://example.com][example link]]")))

  (test-equal "Parse link without description"
    '(div (@ (class "")) (p (a (@ (href "http://example.com")) "")))
    (orgfile->sxml (parse-orgfile "[[http://example.com]]")))

  (test-equal "Parse multiple links in paragraph"
    '(div (@ (class "")) (p (a (@ (href "http://a.com")) "link a") " and " (a (@ (href "http://b.com")) "link b")))
    (orgfile->sxml (parse-orgfile "[[http://a.com][link a]] and [[http://b.com][link b]]"))))

(test-group "paragraph-recognition"
  (test-equal "Parse simple paragraph"
    '(div (@ (class "")) (p "a simple paragraph"))
    (orgfile->sxml (parse-orgfile "a simple paragraph")))

  (test-equal "Parse paragraph with multiple lines"
    '(div (@ (class "")) (p "line one\nline two"))
    (orgfile->sxml (parse-orgfile "line one\nline two")))

  (test-equal "Parse paragraph with trailing whitespace"
    '(div (@ (class "")) (p "trimmed paragraph"))
    (orgfile->sxml (parse-orgfile "  trimmed paragraph  "))))

(test-group "headline-recognition"
  (test-equal "Parse single level headline"
    '(div (@ (class "")) (h1 "A typical org file"))
    (orgfile->sxml (parse-orgfile "* A typical org file")))

  (test-equal "Parse nested headlines"
    '(div (@ (class "")) (h1 "Level 1") (div (@ (class "")) (h2 "Level 2")))
    (orgfile->sxml (parse-orgfile "* Level 1\n** Level 2")))

  (test-equal "Parse headline with tags"
    '(div (@ (class "")) (h1 "Headline with tags"))
    (orgfile->sxml (parse-orgfile "* Headline with tags :tag1:tag2:"))))

(test-end "logs/orgfile-tests")
