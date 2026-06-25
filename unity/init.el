;; ------------------------------------------------------------
;; ------------------------------------------------------------
;;
;;  Link Unity and Emacs
;;
;;  Resources:
;;  https://eliza.sh/2021-06-01-using-unity-editor-with-emacs.html
;;  https://github.com/elizagamedev/unity.el
;;
;;  1. Unity.el
;;      1. Download and copy the unity.el to ~/.emacs.d
;;      2. Load it int the init.el
;;
;;  2. Rider2Emacs
;;      1. Install rider2emacs via cargo install rider2emacs
;;      2. In unity go to preferences > External Tools > Visual Studio Code > Browse > ~/.cargo/bin/rider2emacs
;;      3. make sure a symlink of emacsclient is created under /usr/local/bin
;;
;;  3. Mono Installation [https://www.mono-project.com/download/stable/]
;;
;;  4. Omnisharp Installation  [https://github.com/OmniSharp/homebrew-omnisharp-roslyn]
;;      1. brew tap omnisharp/omnisharp-roslyn
;;      2. brew install omnisharp-mono
;;
;;  5. Emacs Server
;;      1. Method 1:
;;          1. Run emacs daemon with emacs-29.4 —daemon
;;      2. Method 2:
;;          1. Start GUI Emacs
;;          2. M-x server-start
;;      3. Check if daemon is running: emacsclient -e "(daemonp)"
;;      4. To shut down daemon: emacsclient -e "(kill-emacs)"
;;
;;  6. Open Unity For some reason we need to open unity through the terminal
;;     to give it access to all the necessary $PATH so it can access properly either rider2emacs or emacsclient ?
;;      1. Go to the terminal
;;      2. open -a Unity\ Hub
;;
;; ------------------------------------------------------------
;; ------------------------------------------------------------

;; Set environment variable for Mono
;; Make sure to update the path according to the version and OS
(setenv "FrameworkPathOverride" "/lib/mono/4.5")
