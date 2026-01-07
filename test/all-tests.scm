(use-modules (srfi srfi-64)
             (orgfile)
	     (orgfile blocks)
	     (orgfile inlines)
	     (orgfile node)
	     (orgfile sxml)
             (sxml simple))

;; To SXML Test
(test-begin "logs/orgfile-sxml-tests")

(test-group "list-recognition"
  (test-equal "Parse ordered list"
    '((ol ((li ((p "Item 1"))) (li ((p "Item 2"))))))
    (orgfile->sxml (parse-orgfile " 1. Item 1\n 2. Item 2")))

  (test-equal "Parse unordered list with dash"
    '((ul ((li ((p "Item 1"))) (li ((p "Item 2"))))))
    (orgfile->sxml (parse-orgfile " - Item 1\n - Item 2")))

  (test-equal "Parse unordered list with plus"
    '((ul ((li ((p "Item 1"))) (li ((p "Item 2"))))))
    (orgfile->sxml (parse-orgfile " + Item 1\n + Item 2"))))

(test-group "link-recognition"
  (test-equal "Parse link in paragraph"
    '((p (a (@ (href "http://example.com")) "example link")))
    (orgfile->sxml (parse-orgfile "[[http://example.com][example link]]")))

  (test-equal "Parse link without description"
    '((p (a (@ (href "http://example.com")) "")))
    (orgfile->sxml (parse-orgfile "[[http://example.com]]")))

  (test-equal "Parse multiple links in paragraph"
    '((p (a (@ (href "http://a.com")) "link a") " and " (a (@ (href "http://b.com")) "link b")))
    (orgfile->sxml (parse-orgfile "[[http://a.com][link a]] and [[http://b.com][link b]]"))))

(test-group "paragraph-recognition"
  (test-equal "Parse simple paragraph"
    '((p "a simple paragraph"))
    (orgfile->sxml (parse-orgfile "a simple paragraph")))

  (test-equal "Parse paragraph with multiple lines"
    '((p "line one\nline two"))
    (orgfile->sxml (parse-orgfile "line one\nline two")))

  (test-equal "Parse paragraph with trailing whitespace"
    '((p "trimmed paragraph  "))
    (orgfile->sxml (parse-orgfile "  trimmed paragraph  "))))

(test-group "headline-recognition"
  (test-equal "Parse single level headline"
    '((div (@ (class "")) (h1 "A typical org file")))
    (orgfile->sxml (parse-orgfile "* A typical org file")))

  (test-equal "Parse nested headlines"
    '((div (@ (class "")) (h1 "Level 1") (div (@ (class "")) (h2 "Level 2"))))
    (orgfile->sxml (parse-orgfile "* Level 1\n** Level 2")))

  (test-equal "Parse headline with tags"
    '((div (@ (class "tag1 tag2")) (h1 "Headline with tags")))
    (orgfile->sxml (parse-orgfile "* Headline with tags :tag1:tag2:")))

  (test-equal "Parse headline and tags with drawer"
    '((div (@ (class "tag1 tag2")) (h1 "Heading") (details (summary "DrawEr") (dl (dt "Id") (dd "test :tange 1")) (p "Write Content"))))
    (orgfile->sxml (parse-orgfile "* Heading :tag1:tag2: \n:DrawEr:\n:Id: test :tange 1\nWrite Content\n:END:"))))

(test-end "logs/orgfile-sxml-tests")

;; Org File test
(test-begin "logs/orgfile-tests")

(test-group "document-structure"
  (test-assert "Parse document returns document node"
    (document-node? (parse-orgfile "* Heading")))

  (test-equal "Document has section child"
    'section
    (node-type (car (node-children (parse-orgfile "* Heading")))))

  (test-equal "Section has correct level"
    1
    (node-get-data (car (node-children (parse-orgfile "* Heading"))) 'level))

  (test-equal "Section has correct headline"
    "Heading"
    (node-get-data (car (node-children (parse-orgfile "* Heading"))) 'headline))

  (test-equal "Section with tags parses tags correctly"
    '("tag1" "tag2")
    (node-get-data (car (node-children (parse-orgfile "* Heading :tag1:tag2:"))) 'tags))

  (test-equal "Section with paragraph content"
    'paragraph
    (node-type (car (node-children (car (node-children (parse-orgfile "* Heading\na paragraph")))))))

  (test-equal "Section with paragraph has correct text"
    "a paragraph"
    (car (node-children (car (node-children (car (node-children (car (node-children (parse-orgfile "* Heading\na paragraph"))))))))))

  (test-equal "Paragraph node contains text node"
    'text
    (node-type (car (node-children (car (node-children (parse-orgfile "a paragraph")))))))

  (test-equal "Link node has url and description"
    "http://example.com"
    (node-get-data (car (node-children (car (node-children (parse-orgfile "[[http://example.com][example link]]"))))) 'url))

  (test-equal "Document metadata title"
    "Test Title"
    (assq-ref (orgfile-get-metadata (parse-orgfile "#+title: Test Title\n* Heading")) 'title))

  (test-equal "Document metadata custom key"
    "custome"
    (assq-ref (orgfile-get-metadata (parse-orgfile "#+Custome: custome\n* Heading")) 'Custome))

  (test-equal "Document metadata multiple keys"
    3
    (length (orgfile-get-metadata (parse-orgfile "#+title: Test\n#+AUTHOR: Author\n#+Custome: Value\n* Heading")))))

;; Drawer Test
(test-group "test-drawer"
  (test-equal "Section with drawer is correct type"
    'drawer
    (node-type (car (node-children (car (node-children (parse-orgfile "* Heading \n:PROPERTIES:\n:Id: test :tange 1\n:END:")))))))

  (test-equal "Section with drawer is correct drawer name"
    "DrawEr"
    (node-get-data (car (node-children (car (node-children (parse-orgfile "* Heading \n:DrawEr:\n:Id: test :tange 1\n:END:"))))) 'name))

  (test-equal "Section with drawer is correct drawer metadata"
    "test :tange 1"
    (assq-ref (drawer-get-metadata
	       (car (node-children
		     (car (node-children
			   (parse-orgfile "* Heading \n:DrawEr:\n:Id: test :tange 1\n:END:"))))))
	      'Id))

  (test-equal "Section with drawer is correct drawer content"
    "a drawer content"
    (car (node-children
	  (car (node-children
		(car (node-children
		      (car (node-children
			    (car (node-children
				  (parse-orgfile "* Heading \n:Note:\na drawer content\n:END:")))))))))))))

(test-end "logs/orgfile-tests")
