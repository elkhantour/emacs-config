;; slang-mode setup
(add-to-list 'load-path "~/.emacs.d/code")
(require 'slang-mode)

;; Path to slangd
(setq slang-lsp-server-executable "/usr/local/bin/slangd")

;; Check if slangd exists
(unless (executable-find slang-lsp-server-executable)
  (message
   "⚠️  slangd not found! Please:\n\
1. Download Slang binaries from https://github.com/shader-slang/slang/\n\
2. Place them somewhere (e.g., ~/slang)\n\
3. Create a symlink: sudo ln -s ~/slang/slang-<version>/bin/slangd /usr/local/bin/slangd"))

;; lsp-mode setup
(require 'lsp-mode)
;(lsp-register-client
; (make-lsp-client
;  :new-connection (lsp-stdio-connection slang-lsp-server-executable)
;  :major-modes '(slang-mode)
;  :server-id 'slang-lsp))

(lsp-register-client
 (make-lsp-client
  :new-connection (lsp-stdio-connection
                   "/Users/elkhantour/.vscode/extensions/shader-slang.slang-language-extension-2.0.10-darwin-x64/server/bin/darwin-x64/slangd")
  :activation-fn (lsp-activate-on "slang")
  :server-id 'slangd
  :initialized-fn (lambda (workspace)
                    (with-lsp-workspace workspace
                      (lsp--set-configuration
                       (lsp-configuration-section "slang"))))))

(lsp-register-custom-settings
 '(("slang.searchInAllWorkspaceDirectories" t t)))


;; Auto-start lsp in slang-mode buffers
(add-hook 'slang-mode-hook #'lsp);; slang mode 
