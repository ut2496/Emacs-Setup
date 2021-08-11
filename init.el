(setq user-full-name "Utkarsh Shekhar"
      user-mail-address "utkarsh.shekhar@yahoo.co.in")

;;  basic emacs
(setq gc-cons-threshold 50000000)
(setq large-file-warning-threshold 100000000)
(defvar warning-minimum-level :emergency)


;; setup use-package

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-verbose t)

;; basic visuals
(menu-bar-mode 1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(global-hl-line-mode +1)
(blink-cursor-mode -1)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-screen t)
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)
(setq mouse-wheel-progressive-speed nil)

;; backup
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; basic editing
(global-auto-revert-mode t)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq-default tab-width 4
              indent-tabs-mode nil)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(add-hook 'before-save-hook 'whitespace-cleanup)
(global-display-line-numbers-mode 1)

; Packages
(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (show-paren-mode t)))

(use-package expand-region
  :ensure t
  :bind ("M-m" . er/expand-region))

(use-package crux
  :ensure t
  :bind
  ("C-k" . crux-smart-kill-line)
  ("C-c n" . crux-cleanup-buffer-or-region)
  ("C-c f" . crux-recentf-find-file)
  ("C-a" . crux-move-beginning-of-line))

;; git
(use-package magit
  :ensure t
  :bind (("C-M-g" . magit-status)))

;; projectile
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config
  (projectile-mode +1)
  (add-to-list 'projectile-globally-ignored-directories "node_modules")
  (add-to-list 'projectile-globally-ignored-file-suffixes . (".dll"))
  (add-to-list 'projectile-globally-ignored-file-suffixes . (".meta"))
  (add-to-list 'projectile-globally-ignored-file-suffixes . (".pdb"))
  (add-to-list 'projectile-globally-ignored-file-suffixes . (".mdb"))
  (add-to-list 'projectile-globally-ignored-file-suffixes . (".prefab"))
  (add-to-list 'projectile-globally-ignored-file-suffixes . (".png"))
  (add-to-list 'projectile-globally-ignored-file-suffixes . (".jpeg"))
  (add-to-list 'projectile-globally-ignored-file-suffixes . (".aar"))
  (add-to-list 'projectile-globally-ignored-file-suffixes . (".jar"))
  (add-to-list 'projectile-globally-ignored-file-suffixes . (".unitypackage"))
  (add-to-list 'projectile-globally-ignored-file-suffixes . (".pdf"))
  )

;; autocomplete
(use-package company
  :ensure t
  :diminish company-mode
  :config
  (add-hook 'after-init-hook #'global-company-mode))

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

(use-package which-key
  :ensure t
  :delight
  :config
  (which-key-mode +1))

(use-package avy
  :ensure t
  :bind
  ("C-=" . avy-goto-char)
  :config
  (setq avy-background t))

(require 'helm)
(use-package helm
  :ensure t
  :delight
  :defer 2
  :bind
  (("M-x" . helm-M-x)
   ("C-x C-f" . helm-find-files)
   ("M-y" . helm-show-kill-ring)
   ("C-x b" . helm-mini)
   :map helm-map
   ("<tab>" . helm-execute-persistent-action)
   ("C-i" . helm-execute-persistent-action)
   ("C-z" . helm-select-action))
  :config
  (require 'helm-config)
  (helm-mode 1)
  (setq helm-split-window-inside-p t
        helm-move-to-line-cycle-in-source t)
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 20)
  (helm-autoresize-mode 1)
  )

(require 'helm-projectile)
(use-package helm-projectile
  :ensure t
  :bind
  ("C-c p f" . 'helm-projectile-find-file)
  ("C-c p p" . 'helm-projectile-switch-project)
  :config
  (helm-projectile-on))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :mode ("/\\.emacs\\.d/snippets/" . snippet-mode)
  :init
  (progn
    (setq yas-verbosity 3)
    (yas-global-mode 1)))

(use-package yasnippet-snippets
  :ensure t)

(use-package json-mode
  :ensure t)

(use-package npm-mode
  :ensure t)

(use-package rjsx-mode
  :ensure t
  :config
  (setq js-indent-level 2
        js2-mode-show-parse-errors nil
        js2-strict-missing-semi-warning nil)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
  )

(use-package web-mode
  :ensure t
  :mode "\\.html\\'"
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-engines-alist
        '(("ctemplate"    . "\\.html\\'")))
  )

(require 'server)
(if (not (server-running-p)) (server-start))

(use-package omnisharp
  :ensure t
  :bind
  (:map omnisharp-mode-map
        ("C-c C-u" . omnisharp-helm-find-usages)
        ("C-c C-d" . omnisharp-go-to-definition)
        ("C-c C-c" . omnisharp-reload-solution)
        ("C-c r" . omnisharp-rename)
        ("C-c C-r" . pop-tag-mark)))

(add-hook 'csharp-mode-hook 'omnisharp-mode)

(eval-after-load
    'company
  '(add-to-list 'company-backends 'company-omnisharp))

;;(setq projectile-indexing-method 'alien)

(setq projectile-globally-ignored-file-suffixes '(".meta"))

(add-to-list 'command-switch-alist '("(make-frame-visible)" .
                                     (lambda (s))))

(use-package elpy
  :ensure t
  :bind
  (:map elpy-mode-map
        ("C-c C-d" . elpy-goto-definition)
        ("C-c C-u" . xref-find-references)
        ("C-c C-r" . pop-tag-mark))
:init
(elpy-enable))

(use-package telephone-line
  :ensure t
  :config
  (telephone-line-mode 1))


;; theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-vibrant t)
  (doom-themes-visual-bell-config))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(crux expand-region smartparens use-package doom-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
