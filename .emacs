;; -*- mode: emacs-lisp -*-

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d71aabbbd692b54b6263bfe016607f93553ea214bc1435d17de98894a5c3a086" "e964832f274625fa45810c688bdbe18caa75a5e1c36b0ca5ab88924756e5667f" "b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "82360e5f96244ce8cc6e765eeebe7788c2c5f3aeb96c1a765629c5c7937c0b5b" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "1ed5c8b7478d505a358f578c00b58b430dde379b856fbcb60ed8d345fc95594e" "56911bd75304fdb19619c9cb4c7b0511214d93f18e566e5b954416756a20cc80" "379a804655efccc13a3d446468992bfdfc30ff27d19cfda6f62c7f9c9e7a8a7d" "24132f7b6699c6e0118d742351b74141bac3c4388937e40db9207554eaae78c9" "4e764943cc022ba136b80fa82d7cdd6b13a25023da27528a59ac61b0c4f1d16f" "8a0c35b74b0407ca465dd8db28c9136d5f539868d4867565ee214ac85ceb0d3a" "fa3bdd59ea708164e7821574822ab82a3c51e262d419df941f26d64d015c90ee" "b73a23e836b3122637563ad37ae8c7533121c2ac2c8f7c87b381dd7322714cd0" "669e02142a56f63861288cc585bee81643ded48a19e36bfdf02b66d745bcc626" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "973c3250a04a34d7f4f7db2576d19f333ecd6b59ab40c2b9772b007d486b6ab0" "2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" default)))
 '(global-display-line-numbers-mode t)
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(package-selected-packages
   (quote
    (dockerfile-mode neotree which-key org-bullets resize-window company dap-mode helm-lsp lsp-ui lsp-mode company-mode smart-mode-line-powerline-theme powerline-evil powerline atom-one-dark-theme material-theme spacemacs-theme doom-themes zenburn-theme vs-dark-theme evil-collection flycheck-rust flycheck toml-mode cargo-mode rust-mode helm-projectile helm-config helm auto-complete exec-path-from-shell use-package evil)))
 '(tool-bar-mode nil))

;; Disable the splash screen
(setq inhibit-splash-screen t)

;;;;; Customizations

;; Set backup directory
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))

;; Disable that dang bell
(setq ring-bell-function 'ignore)

;; Show line numbers
(global-display-line-numbers-mode)

;; Enable recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;;;;; Flyspell

(dolist (hook '(text-mode-hook org-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))
(dolist (hook '(emacs-lisp-mode-hook lisp-mode-hook))
  (add-hook hook (lambda () (flyspell-prog-mode))))

;;;;; Packages

;; Package repository configuration
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )
(package-initialize)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)


;; Configure use-package
(eval-when-compile
  (require 'use-package))

;; Add exec-path-from-shell
;; (ensures that the PATH is the same as in $SHELL)
(use-package exec-path-from-shell
  :ensure t)
(exec-path-from-shell-initialize)


;;; Org mode
;; Enable
(use-package org
  :ensure t
  :config
  (setq org-directory "~/Dropbox/org")
  (setq org-agenda-files '("~/Dropbox/org"))
  (setq org-default-notes-file "~/Dropbox/org/notes.org")
  :init
  ;; Enable transient mark mode (recommended for org-mode)
  (transient-mark-mode 1)
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c l") 'org-store-link))

(use-package org-bullets
  :ensure t
  :hook
  (org-mode . (lambda () (org-bullets-mode 1))))


;;; Evil mode
(use-package evil
  :ensure t
  :init
  ;; Use C-u to scroll
  (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;;; Auto-Complete
;; (use-package auto-complete
;;   :ensure t
;;   :config
;;   (ac-config-default))
(use-package company
  :ensure t
  :config
  (setq company-minimum-prefix-length 1
      company-idle-delay 0.0)
  :init
  (add-hook 'after-init-hook 'global-company-mode))

;;; Helm
;; TODO: move config into the use-package call
(use-package helm
  :ensure t)
(require 'helm-config)

(setq helm-M-x-fuzzy-match t)
(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 30)
(define-key evil-normal-state-map (kbd "SPC") 'helm-M-x)
(define-key evil-normal-state-map (kbd "M-y") 'helm-show-kill-ring)

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-c h x") 'helm-register)
(global-set-key (kbd "C-c h g") 'helm-google-suggest)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-matching t
      helm-semantic-fuzzy-matching t
      helm-imenu-fuzzy-matching t
      helm-apropos-fuzzy-match t
      helm-echo-input-in-header-line t)

(when (executable-find "rg")
  (setq helm-grep-default-command "rg"
	helm-grep-default-recurse-command "rg"))

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

(helm-autoresize-mode 1)
(helm-mode 1)

;;; Projectile
(use-package projectile
  :ensure t
  :config (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
          (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
          (projectile-mode +1))

;;; Helm-projectile
(use-package helm-projectile
  :ensure t)

;;; Magit
(use-package magit
  :ensure t)

;;; flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))


;;; Language Server
(use-package lsp-mode
  :ensure t
  :config
  (setq lsp-rust-server 'rust-analyzer))
(use-package lsp-ui
  :ensure t)
(use-package helm-lsp
  :ensure t)
(use-package dap-mode
  :ensure t)

;;; Which Key
(use-package which-key
  :ensure t
  :init
  (which-key-mode))

;;; File Tree
(use-package neotree
  :ensure t
  :config
  (setq neo-theme 'ascii)
  (setq neo-smart-open t)
  (setq projectile-switch-project-action 'neotree-projectile-action)
  :init
  (global-set-key (kbd "C-c f") 'neotree-toggle))

;;; Ace Window
(use-package ace-window
  :ensure t
  :init
  (global-set-key (kbd "M-o") 'ace-window))


;;; Themes & Editor Config
(use-package one-themes
  :ensure t)
(use-package vs-dark-theme
  :ensure t)
;; (use-package zenburn-theme
;;   :ensure t)
(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-italic t)
  (doom-themes-org-config))
;; (use-package material-theme
;;   :ensure t)
;; (use-package atom-one-dark-theme
;;   :ensure t)
(use-package one-themes
  :ensure t)
;; (use-package powerline
;;   :ensure t
;;   :config
;;   (setq powerline-default-separator 'arrow)
;;   :init
;;   (powerline-default-theme))
;; (use-package powerline-evil
;;   :after powerline
;;   :ensure t)

(use-package smart-mode-line-powerline-theme
  :ensure t)

(use-package smart-mode-line
  :ensure t
  :init
  (sml/setup))

(load-theme 'doom-dark+ t)

(use-package resize-window
  :ensure t
  :init
  (global-set-key (kbd "C-c ;") 'resize-window))

(add-to-list 'resize-window-alias-list '(k ?n))
(add-to-list 'resize-window-alias-list '(j ?p))
(add-to-list 'resize-window-alias-list '(h ?b))
(add-to-list 'resize-window-alias-list '(l ?f))


;;; Languages

;; Rust
(use-package rust-mode
  :ensure t
  :config
  (setq rust-format-on-save t)
  :hook
  (rust-mode . (lambda () (setq indent-tabs-mode nil))))

(use-package flycheck-rust
  :ensure t)

(use-package toml-mode
  :ensure t)

;; Docker
(use-package dockerfile-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-to-list 'auto-mode-alist '("\\.toml\\'" . toml-mode))

;;; General Keybindings


(global-set-key (kbd "C-x h") 'help-for-help)


(org-todo-list)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
