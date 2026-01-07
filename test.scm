;; TODO 重构这个文件的代码，将段落识别、标题识别、链接识别、列表识别分别作为单独的单元测试，并写进test文件夹中。orgfile->sxml的期望输出格式是sxml格式。
(use-modules (orgfile)
             (sxml simple))

(define org-text
  "* A typical org file

a paragraph with an [[http://example.com][example link]]

** Sections can be nested

 1. List item 1
 2. List item 2
 
 
 another paragraph.")

;; Parse the org document
(define doc (parse-orgfile org-text))

;; Convert the document to sxml and write to current output port
(sxml->xml (orgfile->sxml doc))

;; Output
"<div class=\"\"><h1>A typical org file</h1><p>a paragraph with an <a href=\"http://example.com\">example link</a></p><div class=\"\"><h2>Sections can be nested</h2><ol><li><p>List item 1</p></li><li><p>List item 2</p></li></ol><p>another paragraph.</p></div></div>"
