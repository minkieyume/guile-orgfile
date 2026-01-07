(use-modules (srfi srfi-64)
             (orgfile)
             (sxml simple))

(test-begin "logs/paragraph-recognition")

(test-equal "Parse simple paragraph"
  '(div (@ (class "")) (p "a simple paragraph"))
  (orgfile->sxml (parse-orgfile "a simple paragraph")))

(test-equal "Parse paragraph with multiple lines"
  '(div (@ (class "")) (p "line one\nline two"))
  (orgfile->sxml (parse-orgfile "line one\nline two")))

(test-equal "Parse paragraph with trailing whitespace"
  '(div (@ (class "")) (p "trimmed paragraph"))
  (orgfile->sxml (parse-orgfile "  trimmed paragraph  ")))

(test-end "logs/paragraph-recognition")
