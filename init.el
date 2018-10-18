(setq user-full-name "Utkarsh Shekhar"
      user-mail-address "ushekhar@livelikevr.com")


;;  basic emacs
(setq gc-cons-threshold 50000000)
(setq large-file-warning-threshold 100000000)
(setq warning-minimum-level :emergency)


;; setup use-package
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(package-initialize)
(elpy-enable)

(add-hook 'elpy-mode-hook
    (lambda ()
      (define-key elpy-mode-map (kbd "C-c C-d") 'elpy-goto-definition)
      (define-key elpy-mode-map (kbd "C-c C-u") 'xref-find-references)
      (define-key elpy-mode-map (kbd "C-c C-r") 'pop-tag-mark)))


(load "D:\\Emacs\\csharp-mode.el")

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
(set-frame-font "Hack 12" nil t)


;; backup
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-vibrant t)
  (doom-themes-visual-bell-config))


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


;; Packages
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

(use-package 'omnisharp)

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
  )
(setq projectile-indexing-method 'turbo-alien)

;; autocomplete
(use-package company
  :ensure t
  :diminish company-mode
  :config
  (global-company-mode))

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

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

;; (use-package smart-shift
;;   :ensure t
;;   :config
;;   (global-smart-shift-mode 1))


(use-package helm
  :ensure t
  :delight
  :defer 2
  :bind
  ("M-x" . helm-M-x)
  ("C-x C-f" . helm-find-files)
  ("M-y" . helm-show-kill-ring)
  ("C-x b" . helm-mini)
  :config
  (require 'helm-config)
  (helm-mode 1)
  (setq helm-split-window-inside-p t
    helm-move-to-line-cycle-in-source t)
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 20)
  (helm-autoresize-mode 1)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
  )

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

(use-package omnisharp
  :ensure t
  :config
  (define-key omnisharp-mode-map (kbd "C-c C-u") 'omnisharp-helm-find-usages)
  (define-key omnisharp-mode-map (kbd "C-c C-d") 'omnisharp-go-to-definition)
  (define-key omnisharp-mode-map (kbd "C-c C-c") 'omnisharp-reload-solution)
  (define-key omnisharp-mode-map (kbd "C-c C-r") 'omnisharp-rename))

(add-hook 'csharp-mode-hook 'omnisharp-mode)

(eval-after-load
 'company
 '(add-to-list 'company-backends 'company-omnisharp))

(defun git-bash () (interactive)
  (let ((explicit-shell-file-name "c:/Program Files/Git/bin/bash.exe"))
    (call-interactively 'shell)))

(setq omnisharp-server-executable-path "c:/Users/ushek/AppData/Roaming/.emacs.d/.cache/omnisharp/server/v1.32.1/OmniSharp.exe")

(setq projectile-indexing-method 'alien)
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


(add-to-list 'command-switch-alist '("(make-frame-visible)" .
                                     (lambda (s))))

(require 'server)
(if (not (server-running-p)) (server-start))

(use-package elpy
  :ensure t
  :config
  (elpy-enable))

(use-package telephone-line
  :ensure t
  :config
  (telephone-line-mode 1))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" "356e5cbe0874b444263f3e1f9fffd4ae4c82c1b07fe085ba26e2a6d332db34dd" "93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" "75d3dde259ce79660bac8e9e237b55674b910b470f313cdf4b019230d01a982a" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" default)))
 '(org-export-backends (quote (ascii html icalendar latex md)))
 '(package-selected-packages
   (quote
    (elpygen dracula-theme fireplace nyan-mode telephone-line symon xkcd zenburn-theme elpy ag smart-mode-line-powerline-theme smart-mode-line indent-guide yasnippet-snippets omnisharp markdown-mode slime helm-ag web-mode helm-projectile rjsx-mode npm-mode json-mode yasnippet dashboard helm avy undo-tree which-key flycheck company projectile magit crux expand-region smartparens nlinum doom-themes use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(show-paren-match ((t (:background "#1B2229" :foreground "#ff6c6b")))))
(put 'narrow-to-region 'disabled nil)
