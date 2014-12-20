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
    magit
    multiple-cursors
    projectile
    smartparens))

(setq package-enable-at-startup nil)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(setq other-packages
      '((better-defaults . "melpa")))

(setq package-pinned-packages
      (let ((cons-stable (lambda (p) (cons p "melpa-stable"))))
        (mapcar cons-stable stable-packages)))

(dolist (p (nconc stable-packages (mapcar 'car other-packages)))
  (if (not (package-installed-p p))
      (package-install p)))

(global-set-key "\C-cs" 'magit-status)

(projectile-global-mode)

(require 'smartparens-config)
(smartparens-global-mode t)

(require 'whitespace)
(setq whitespace-style '(empty tabs trailing lines-tail face))
(setq whitespace-line-column 125)
(global-whitespace-mode t)

(setq c-basic-offset 2)     ;; how far to indent
(setq tab-width 4)          ;; interpretation of ascii 9
(setq indent-tabs-mode nil) ;; don't use ascii byte #9

(setq frame-title-format '(:eval (if (buffer-file-name) "%b — %f" "%b")))

(setq max-specpdl-size 10) ; limit stack size in elisp
(setq debug-on-error t)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
