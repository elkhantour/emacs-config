;; Hide unecessary file
;; Source - https://stackoverflow.com/a/43632653
(require 'dired-x)
(add-hook 'dired-mode-hook #'dired-omit-mode)
(setq dired-omit-files
      (rx (or (seq bol (? ".") "#")
              (seq bol "." eol)
	      (seq "." "DS_Store" eol)
              (seq "." "meta" eol))))

;; Disable subdir cause it cause freeze when using ^ to go up to parent dir
(with-eval-after-load 'dired
  (define-key dired-mode-map "$" nil))
