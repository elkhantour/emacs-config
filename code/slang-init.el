(add-to-list 'load-path (expand-file-name "~/.emacs.d/code"))
(require 'slang-mode)
(require 'lsp-mode)

;; Path to slangd
(setq slang-lsp-server-executable "/usr/local/bin/slangd")

;; Check if slangd exists
(unless (executable-find slang-lsp-server-executable)
  (message
   "⚠️  slangd not found! Please:\n\
1. Download Slang binaries from https://github.com/shader-slang/slang/\n\
2. Place them somewhere (e.g., ~/slang)\n\
3. Create a symlink: sudo ln -s ~/slang/slang-<version>/bin/slangd /usr/local/bin/slangd"))

;; Must be at the front of the list, since slang-mode derives from c-mode
(add-to-list 'lsp-language-id-configuration '(slang-mode . "slang"))

(lsp-register-custom-settings
 '(("slang.searchInAllWorkspaceDirectories" t t)))

(lsp-register-client
 (make-lsp-client
  :new-connection (lsp-stdio-connection slang-lsp-server-executable)
  :activation-fn (lsp-activate-on "slang")
  :priority 1
  :multi-root t
  :server-id 'slangd
  :initialized-fn (lambda (workspace)
                    (with-lsp-workspace workspace
                      (lsp--set-configuration
                       (lsp-configuration-section "slang"))))))

;(setq lsp-enabled-clients '(slangd))
(add-hook 'slang-mode-hook #'lsp)
