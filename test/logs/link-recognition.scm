(use-modules (srfi srfi-64)
             (orgfile)
             (sxml simple))

(test-begin "logs/link-recognition")

(test-equal "Parse link in paragraph"
  '(div (@ (class "")) (p (a (@ (href "http://example.com")) "example link")))
  (orgfile->sxml (parse-orgfile "[[http://example.com][example link]]")))

(test-equal "Parse link without description"
  '(div (@ (class "")) (p (a (@ (href "http://example.com")) "")))
  (orgfile->sxml (parse-orgfile "[[http://example.com]]")))

(test-equal "Parse multiple links in paragraph"
  '(div (@ (class "")) (p (a (@ (href "http://a.com")) "link a") " and " (a (@ (href "http://b.com")) "link b")))
  (orgfile->sxml (parse-orgfile "[[http://a.com][link a]] and [[http://b.com][link b]]")))

(test-end "logs/link-recognition")
