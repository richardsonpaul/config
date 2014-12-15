(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(desktop-save-mode t)
 '(inhibit-startup-screen t)
 '(use-dialog-box nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -l -c 'echo -n $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(if window-system (set-exec-path-from-shell-PATH))

(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
  '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)
(package-initialize)

(setq my-packages
  '(magit
;    expand-region
; descbinds-anything
; goto-last-change
; gnus
; bbdb
; pgdevenv-el
; mbsync
; smex
; geiser
 multiple-cursors
; anything
; pcmpl-git
; magit-view-file
; emacs-goodies-el
; sicp
; auto-dictionnary
; keywiz
; pandoc-mode
; psql-linum-format
; psvn
; rect-mark
; crontab-mode
; incomplete+
; php-mode-improved
; rainbow-delimiters
; muse
; deft
; dpans2texi
; markdown-mode
; color-theme-solarized
; protobuf-mode

    ;; cssh
    ;; asciidoc
    ;; lisppaste
    better-defaults
    ;; switch-window
    ;; vkill
    ;; google-maps
    ;; nxhtml
    ;; xcscope
    ;; yasnippet
    ;; escreen
    ;; switch-window
    auto-complete
    ;; zencoding-mode
    ;; color-theme
    ;; color-theme-tango
    paredit

; clj-refator
; idle-highlight-mode
; smeargle
; quickrun
; restclient
; sqlup
; paradox
; git-timemachine
; diff-hl (or h1)
; agda2-mode

; LOST -------
; saveplace
; malabar-mode

 projectile
; wgrep
; ido-ubiquitous
; ac-nrepl
; ace-jump-mode
; emmet-mode
; etags-select
; expand-region
; fill-column-indicator
; flycheck-hdevtools
; fuzzy
; ghc-mod
; ghci-completion
; gist
; go-mode
; guru-mode
; highlight-parentheses
; highlight-symbol
; hl-sexp
; idle-highlight-mode
; twittering-mode
; ido-menu
; inf-ruby
; key-chord
; nav
; robe-mode
; undo-tree
; yasnippet
; color-theme-tomorrow
; col-highlight
; fuzzy-match
; iy-go-to-char
; mic-paren
; tagedit

; exec-path-from-shell
; clojure-mode-extra-font-locking
; company
; ack-and-a-half
; modes: scss coffee yaml enh-ruby
; ag

; buffer-move
    cider))

(if (not (package-installed-p 'package-filter))
    (progn
      (switch-to-buffer
       (url-retrieve-synchronously
        "https://raw.github.com/milkypostman/package-filter/master/package-filter.el"))
      (package-install-from-buffer  (package-buffer-info) 'single)))

(setq package-archive-enable-alist
      '(("melpa" better-defaults)))

(package-refresh-contents)

(dolist (p my-packages)
  (if (not (package-installed-p p))
      (package-install p)))

(autoload 'enable-paredit-mode "paredit" nil t)
(add-hook 'emacs-list-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)

(require 'whitespace)
(setq whitespace-style '(empty tabs trailing lines-tail face))
(setq whitespace-line-column 120)
(global-whitespace-mode t)

(setq frame-title-format '(:eval (if (buffer-file-name) "%b — %f" "%b")))

; use forward symbol instead of forward-word
; key bindings

(setq max-specpdl-size 10)
(setq debug-on-error t)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
