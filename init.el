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
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("ELPA" . "http://tromey.com/elpa/")
        ("melpa" . "http://melpa.milkbox.net/packages/")
        ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")))

(setq stable-packages
  '(cider
    clj-refactor
    expand-region
    flx-ido
    magit
    multiple-cursors
    projectile
    smartparens
    yasnippet))

(setq package-enable-at-startup nil)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(setq other-packages
      '((better-defaults . "melpa")
        (switch-window . "melpa")))

(setq package-pinned-packages
      (nconc other-packages
       (let ((cons-stable (lambda (p) (cons p "melpa-stable"))))
         (mapcar cons-stable stable-packages))))

(dolist (p (nconc stable-packages (mapcar 'car other-packages)))
  (if (not (package-installed-p p))
      (package-install p)))

;; individual package config

;; cider
(add-hook 'cider-mode-hook
          (lambda ()
            (define-key cider-mode-map (kbd "<s-tab>") 'complete-symbol)
            (define-key cider-mode-map (kbd "C-c C-c") 'nrepl-close)))
(setq cider-show-error-buffer nil)
(setq cider-repl-history-file "cider-repl-history")
(setq cider-repl-history-size 10000)

;; clj-refactor
(add-hook 'clojure-mode-hook
          (lambda ()
            (clj-refactor-mode 1)
            (cljr-add-keybindings-with-prefix "C-c C-v")))

;; clojure-mode
(setq clojure-defun-style-default-indent t)

;; (require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; (require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
;; (setq flx-ido-use-faces nil)

(global-set-key "\C-cs" 'magit-status)

;; (require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C->") 'mc/skip-to-next-like-this)

(projectile-global-mode)

(require 'smartparens-config)
(smartparens-global-mode t)
(setq sp-navigate-close-if-unbalanced t)
(sp-use-smartparens-bindings)
(define-key sp-keymap (kbd "s-s") 'sp-splice-sexp)
(define-key sp-keymap (kbd "s-0") 'sp-forward-slurp-sexp)
(define-key sp-keymap (kbd "s-9") 'sp-backward-slurp-sexp)
(define-key sp-keymap (kbd "s-[") 'sp-backward-barf-sexp)
(define-key sp-keymap (kbd "s-]") 'sp-forward-barf-sexp)
(define-key sp-keymap [M-backspace] 'sp-backward-kill-symbol)
(define-key sp-keymap [s-backspace] 'sp-backward-kill-word)
(define-key sp-keymap (kbd "s-d") 'sp-kill-word)
(define-key sp-keymap (kbd "M-d") 'sp-kill-symbol)
(define-key sp-keymap (kbd "M-f") 'sp-forward-symbol)
(define-key sp-keymap (kbd "s-f") 'forward-word)
(define-key sp-keymap (kbd "M-b") 'sp-backward-symbol)
(define-key sp-keymap (kbd "s-b") 'backward-word)
(define-key sp-keymap (kbd "C-S-a") 'sp-beginning-of-sexp)
(define-key sp-keymap (kbd "C-S-e") 'sp-end-of-sexp)
(define-key sp-keymap (kbd "C-S-<backspace>") nil)
(sp-pair "(" ")" :wrap (or "A-9" "A-("))
(sp-pair "[" "]" :wrap "A-[")
(sp-pair "{" "}" :wrap (or "H-[" "A-{"))
(sp-local-pair 'html-mode "<span class=\"bold\">" "</span>" :insert "C-c b" :wrap "C-c C-b")
(mapc
 (lambda (mode)
   (add-hook mode
             (lambda ()
               (local-set-key (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around))))
 '(emacs-lisp-mode-hook lisp-interaction-mode-hook))
(add-hook 'clojure-mode-hook
          (lambda ()
            (local-set-key (kbd "C-S-<backspace>") 'cljr-raise-sexp)))

(global-set-key (kbd "C-x o") 'switch-window)

;; (require 'whitespace)
(setq whitespace-style '(empty tabs trailing lines-tail face))
(setq whitespace-line-column 125)
(global-whitespace-mode t)
(global-set-key [?\s- ] 'fixup-whitespace)

;; yasnippet
(yas-global-mode 1)

;; miscellaneous config

(setq c-basic-offset 2)     ;; how far to indent
(setq tab-width 4)          ;; interpretation of ascii 9
(setq indent-tabs-mode nil) ;; don't use ascii byte #9

(setq frame-title-format '(:eval (if (buffer-file-name) "%b — %f" "%b")))

(setq max-specpdl-size 10) ; limit stack size in elisp
(setq debug-on-error t)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(setq mac-right-command-modifier 'alt)
(setq mac-right-option-modifier 'hyper)

(setq gc-cons-threshold 20000000)
