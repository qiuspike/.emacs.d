(require 'package)

;; default start directory
(setq default-directory "~/leancloud/code/uluru/uluru-platform")

;; ====

(defun randx (xs)
  "Choose an item from list at random."
  (elt xs (random (length xs))))

;; ====
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(setq exec-path (append exec-path '("/usr/local/bin")))

(setq linum-format " %d")
(global-linum-mode t)
(global-hl-line-mode t) ;; highlight current line
(setq column-number-mode t) ;; show current column number

;;(setq fav-font (car (list "Fira Code" "M+ 1mn" "Consolas"
;;                          "Source Code Pro" "Monaco")))

(setq fav-font (car (list "Monaco")))
(message "Loading font %s" fav-font)
(set-face-attribute 'default nil
                    :family fav-font
                    :weight 'light
                    :height 140) ;; set font size in 1/10 pt
(add-hook 'prog-mode-hook #'eldoc-mode)
(setq use-package-always-ensure t)
(use-package better-defaults
  :config
  (setq visible-bell nil))

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode t)
  (define-key evil-normal-state-map (kbd "q") nil)
  )
;; normal emacs 
(setq evil-default-state 'normal)
;; define 'space' as leader key
(evil-set-leader 'normal (kbd "SPC"))
(evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)

;; window commands
(evil-define-key 'normal 'global (kbd "<leader>h") 'evil-window-left)
(evil-define-key 'normal 'global (kbd "<leader>j") 'evil-window-down)
(evil-define-key 'normal 'global (kbd "<leader>k") 'evil-window-up)
(evil-define-key 'normal 'global (kbd "<leader>l") 'evil-window-right)
(evil-define-key 'normal 'global (kbd "<leader>c") 'evil-window-delete)
(evil-define-key 'normal 'global (kbd "<leader>s") 'evil-window-split)
(evil-define-key 'normal 'global (kbd "<leader>v") 'evil-window-vsplit)
(evil-define-key 'normal 'global (kbd "<leader>q") 'evil-quit)

;;(evil-define-key 'normal 'global (kbd "<leader>q") 'evil-quit)
;;(evil-define-key 'normal 'global (kbd "<leader>q") 'evil-quit)
(evil-define-key 'normal 'global (kbd "M-.") nil)
(evil-define-key 'normal 'global (kbd "C-e") nil)
(evil-define-key 'normal 'global (kbd "s") nil)
(evil-define-key 'normal 'global (kbd "S") 'evil-write)
(evil-define-key 'normal 'global (kbd "Q") 'evil-quit)
;; TODO 
(evil-define-key 'normal 'global (kbd "gd") 'cider-find-var)

(use-package helm
  :config
  (helm-mode 1)
  (global-set-key (kbd "<leader>x") 'helm-M-x)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
  )
(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))
(use-package smartparens
  :config
  (smartparens-global-mode t))
(use-package rainbow-delimiters
  :config
  (custom-set-faces
    '(rainbow-delimiters-unmatched-face ((t (:background "#f00" :foreground "#fff")))))
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

; (use-package color-theme)
; (defun solarize-frame (frame)
;   (set-frame-parameter frame
;                        'background-mode
;                        (if (display-graphic-p frame) 'dark 'light))
;   (message "solarize frame")
;   (enable-theme 'solarized))
; (use-package color-theme-solarized
;   :config
;   (load-theme 'solarized t)
;   (add-hook 'after-make-frame-functions
;             'solarize-frame)
;   (solarize-frame nil) ;; solarize the init frame
;   )
; (use-package darktooth-theme)
; (use-package monokai-theme)
; (use-package idea-darkula-theme)
(use-package atom-one-dark-theme
             :config
             (load-theme 'atom-one-dark t))

(use-package flycheck
             :config
             (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package math-symbol-lists
  :config
  (add-to-list 'math-symbol-list-basic '("misc" "\\euler" #X212F)))

(use-package company-math
  :config
  (add-to-list 'company-backends 'company-math-symbols-unicode))

(use-package perspective
  :config
  (add-hook 'prog-mode-hook #'persp-mode))
(use-package clojure-mode
  :mode
  ("\\.clj\\'" . clojure-mode)
  ("\\.cljs\\'" . clojure-mode)
  :config
  (add-hook 'clojure-mode-hook #'eldoc-mode))

(use-package cider
  :defer t
  :config
  (add-hook 'cider-repl-mode-hook #'eldoc-mode))

(use-package dockerfile-mode
  :mode
  ("\\Dockerfile\\'" . dockerfile-mode))
(use-package go-mode
  :mode "\\.go\\'")
(use-package markdown-mode
  :mode
  ("\\.md\\'" . markdown-mode)
  ("\\.mkd\\'" . markdown-mode))

;;(use-package js2-mode
;;  :mode
;;  ("\\.js\\'" . js2-mode)
;;  ("\\.jsx\\'" . js2-jsx-mode)
;;  :config
;;  (add-hook 'js2-mode-hook
;;            (lambda () (setq js2-basic-offset 2)))
;;  (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode)))

;; (use-package racket-mode)
(use-package rust-mode
             :mode "\\.rs\\'")
(use-package yaml-mode
  :mode "\\.yml\\'")
(use-package ess :defer t) ;; emacs speaks statistics
(use-package neotree
   :init (setq neo-smart-open t) 
   :config
   (add-hook 'neotree-mode-hook
               (lambda ()
                 (define-key evil-normal-state-local-map (kbd "u") 'neotree-enter)
                 (define-key evil-normal-state-local-map (kbd "o") 'neotree-enter)
                 (define-key evil-normal-state-local-map (kbd "O") 'neotree-enter)
                 ;; (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
                 (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter))))

(evil-define-key 'normal 'global (kbd "<leader>t") 'neotree-toggle)

;; (use-package projectile)
;; (use-package jdee) ;; java
(add-hook 'python-mode-hook
          (lambda ()
            (when (executable-find "ipython3")
              (setq python-shell-interpreter "ipython3")
              (setq python-shell-interpreter-args "--simple-prompt"))
            (setenv "PYTHONIOENCODING" "utf-8")
            (setq indent-tabs-mode nil)
            (setq python-indent 4)))

(add-hook 'ruby-mode-hook 'robe-mode)

;; Basic config
(setq inhibit-startup-screen t) ;; no splash screen
; (setq initial-buffer-choice "~/dev/spark/spark.md")

;; make a newline at end of file, for git
(setq require-final-newline t)

;; (defun my-jump-to-tag ()
;;   (interactive)
;;   (evil-emacs-state)
;;   (call-interactively (key-binding (kbd "M-.")))
;;   (evil-change-to-previous-state (other-buffer))
;;   (evil-change-to-previous-state (current-buffer)))
;; (define-key evil-normal-state-map (kbd "C-]") 'my-jump-to-tag)

(defun buffer-kill-others ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer
        (delq (current-buffer)
              (remove-if-not 'buffer-file-name (buffer-list)))))

(defun buffer-kill-all ()
  "Kill all buffers, including active one."
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(defun my-etags-update (dir-name)
    "Create ctags/etags table with exuberant ctags."
    (interactive "DDirectory: ")
    (shell-command
     (format "ctags -e -R %s" (directory-file-name dir-name))))

;; unbind print shortcut key
(global-unset-key (kbd "s-p"))

(let ((openssl-include-dir (shell-command-to-string
                            "$SHELL --login -c 'echo -n $OPENSSL_INCLUDE_DIR'"))
      (dep-openssl-include (shell-command-to-string
                            "$SHELL --login -c 'echo -n $DEP_OPENSSL_INCLUDE'"))
      (jvm-opts (concat (getenv "JVM_OPTS")
                        "-Darchaius.configurationSource.additionalUrls=file:////Users/QY/leancloud/code/uluru/uluru-platform/config/local/yqiu_config.properties")))
  (progn
    (setenv "JVM_OPTS" jvm-opts)
    (setenv "OPENSSL_INCLUDE_DIR" openssl-include-dir)
    (setenv "DEP_OPENSSL_INCLUDE" dep-openssl-include)))
(put 'upcase-region 'disabled nil)


;; fira code
;; Enable the www ligature in every possible major mode
;; (ligature-set-ligatures 't '("www"))

;; Enable ligatures in programming modes                                                           
;; (ligature-set-ligatures 'prog-mode '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
;;                                     ":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
;;                                     "-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
;;                                     "#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
;;                                     "/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
;;                                     "++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
;;                                     "=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
;;                                     "<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
;;                                     "<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
;;                                     "<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))

;; (global-ligature-mode 't)
