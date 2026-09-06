;; set "gnu" style indenting for c
(setq c-default-style "linux"
      c-basic-offset 4)

;; turn on electric pair mode (pair parenthesis, braces...)
(electric-pair-mode 1)

;; Remapping keyboard M = cmd
(setq mac-option-modifier 'nil
      ns-command-modifier 'meta)

;; Display line number
(add-hook 'prog-mode-hook 'display-line-numbers-mode)


;; Copy line
(defun copy-line ()
  (interactive)
  (save-excursion
    (back-to-indentation)
    (kill-ring-save
     (point)
     (line-end-position)))
  (message "1 line copied"))
(global-set-key "\C-c\C-l" 'copy-line)

;; set code session window layout
(defun code-layout ()
  "Set up a specific window layout:
- Left: Main window showing dired.
- Right (Top): Also showing dired.
- Right (Bottom): Shell in the current directory, renamed to
  \"shell - <directory>\"."
  (interactive)
  (delete-other-windows)
  ;; Create the left window first
  (let* ((main (selected-window))
         (right (split-window main nil 'right))
         (bottom-right (split-window right nil 'below))
         (dir-name (file-name-nondirectory
                    (directory-file-name default-directory))))
    ;; Open Dired in the left window (main)
    (dired default-directory)
    ;; Open Dired in the top-right window
    (select-window right)
    (dired default-directory)
    ;; Open Shell in the bottom-right window
    (select-window bottom-right)
    (shell)
    (rename-buffer (format "shell - %s" dir-name) t)
    ;; Return focus to main window (left)
    ;; (select-window main)
    ))
(global-set-key (kbd "C-c c") 'code-layout) ;; Bind to a shortcut

;; Rename created shell with a unique name according to time
(defun my/shell-buffer-name ()
  "Generate a unique shell buffer name based on the current time (HHMMSS)."
  (generate-new-buffer-name
   (format "shell - %s" (format-time-string "%H%M%S"))))

(advice-add 'shell :around
            (lambda (orig-fun &rest args)
              (apply orig-fun (or (car args) (my/shell-buffer-name)) (cdr args))))

;; git gutter
(use-package git-gutter
  :ensure t
  :hook (prog-mode . git-gutter-mode)
  :config
  (global-git-gutter-mode))

(global-set-key (kbd "C-x g") 'git-gutter-mode)


;; auto reload file on change
(global-auto-revert-mode t)

;; auto make file mode
(setq auto-mode-alist
      (append '(("Makefile\\'" . makefile-mode)
                ("makefile\\'" . makefile-mode))
              auto-mode-alist))


;; auto find Makefile and compile on C-c m
(defun my/compile-in-project-root ()
  "Run make from the nearest parent directory containing a Makefile."
  (interactive)
  (let ((root (locate-dominating-file default-directory "Makefile")))
    (if root
        (let ((compile-command (format "make -C %s" root)))
          (compile compile-command))
      (message "No Makefile found in any parent directory."))))

(global-set-key (kbd "C-c m") 'my/compile-in-project-root)


;; htop command
(defun htop ()
  "Open htop in a new terminal buffer and rename it to *htop*."
  (interactive)
  (let ((term-buffer (term "/bin/bash")))
    (with-current-buffer term-buffer
      (rename-buffer "*htop*" t)
      (term-send-raw-string "htop\n"))
    (switch-to-buffer term-buffer)))



;; DELETEME
;; treesite-auto
;; (use-package treesit-auto
;;  :ensure t
;;  :custom
;;  (treesit-auto-install 'prompt)
;;  :config
;;  (treesit-auto-add-to-auto-mode-alist 'all)
;;  (global-treesit-auto-mode))



;; Yasnippet
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

;; Optional: collection of ready-made snippets
(use-package yasnippet-snippets
  :ensure t)

;; tells company to works with yassnippet
(setq company-backends '((company-yasnippet company-capf)))


;; NASM assembly handling
(require 'nasm-mode)
(add-to-list 'auto-mode-alist '("\\.nasm\\'" . nasm-mode))

;; C# Mode
(add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-mode))
