(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(package-initialize)
;(package-refresh-contents)
;(let ((muh-packages '(
		      ;;; required by evil mode on newer emacsen
		      ;undo-tree
		      ;undo-fu
		      ;goto-last-change
		      ;;; fundamental
		      ;evil
		      ;neotree
		      ;color-theme-modern
		      ;;; almost fundamental
		      ;flycheck
		      ;auto-complete
		      ;;; colours
		      ;color-theme-modern
		      ;dracula-theme
		      ;solarized-theme
		      ;;; ides
		      ;sly
		      ;; geiser
		      ;; geiser-racket
		      ;; geiser-guile
		      ;ess
		      ;ediprolog
		      ;auctex
		      ;;; language support
		      ;sxhkdrc-mode ;(not supported in older emacsen)
		      ;;; utilities
		      ;beacon
		      ;;; and this is where things get get stupid
		      ;yasnippet
		      ;yasnippet-snippets
		      ;company
		      ;olivetti
		      ;all-the-icons
		      ;)))
  ;(mapc (lambda (pkg)
	  ;(unless (package-installed-p pkg)
	    ;(package-install pkg)))
	;muh-packages))

;;; settings for the packages
;;; I have yet to learn use-package

;; evil mode
; I want insert state to be emacs state, it's just better
; that said, using emacs and insert mode in a terminal kinda blows, esc never registers right
(setq evil-disable-insert-state-bindings t)
(require 'evil)
(setq evil-esc-delay 0.0)
(evil-mode 1)
(evil-normal-state)

;; neotree
(require 'neotree)
(setq neotree-smart-open t)

;; company
(require 'company)
(add-hook 'after-init-hook  'global-company-mode)
(setq company-miminum-prefix-length 3)
;; https://emacs.stackexchange.com/questions/13286/
(with-eval-after-load 'company
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "<tab>") 'company-complete-selection))
;; eglot
(with-eval-after-load 'eglot
  (progn
    (add-to-list 'eglot-server-programs
		 ;; mildly sacrilegous, sorry gerald
		 '(scheme-mode . ("racket" "-l" "racket-langserver")))
    (add-to-list 'eglot-server-programs
		 ;; mildly sacrilegous, sorry gerald
		 '(js-mode . ("npx" "typescript-language-server" "--stdio")))))

;; common lisp has no language server, eh

;; lsp java
; (require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)

;; general lsp bullshit
(setq read-process-output-max (* 1024 1024))
(setq gc-cons-threshold 102400000)

;; ess
(require 'ess)
(setq ac-use-quick-help nil)

;; beacon
(require 'beacon)
(beacon-mode 1)

;; yas
(require 'yasnippet)
(yas-global-mode 1)


;; praise be to the mode of org
(require 'org-tempo)
(require 'ob-python)
(require 'ob-lisp)
(require 'ob-scheme)

;;; org
;; some blaitant theft later
;; from https://zzamboni.org/post/beautifying-org-mode-in-emacs/
(setq org-hide-emphasis-markers t)

(add-hook 'org-mode-hook (lambda () (progn
					(auto-fill-mode)
					(setq truncate-lines nil)
					(setq truncate-partial-width-windows nil)    
					(org-bullets-mode)
					(setq fill-column 90))))

(add-to-list 'org-preview-latex-process-alist 'dvipng)
;; org language settings
;; partially copied from https://plantuml.com/emacs (for the plantuml part)
(setq org-plantuml-jar-path (expand-file-name "/home/diccu/uml/plantuml.jar")) 
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
(add-to-list 'org-src-lang-modes '("lisp" . lisp))
(add-to-list 'org-src-lang-modes '("python" . python))
(add-to-list 'org-src-lang-modes '("scheme" . scheme))

(setq org-babel-lisp-eval-fn 'sly-eval)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (plantuml . t)
   (python . t)
   (lisp . t)
   (scheme . t)))

;;; latex
;; stolen from https://www.emacswiki.org/emacs/AUCTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
; (add-hook 'LaTeX-mode-hook 'flyspell-mode) ; doesn't work too well for non english
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;; other language settings
(setq inferior-lisp-program "sbcl")
(setq scheme-program-name "guile3.0")
(modify-coding-system-alist 'file "\\.tex\\'" 'utf-8)

(setq prolog-system 'swi)

;;; personal preferences, convenience, and sanity
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq ring-bell-function 'ignore)
(setq c-basic-offset 4)
(setq python-indent-offset 4)
(setq tab-width 4)

(setq scroll-conservatively most-positive-fixnum)

(show-paren-mode t)

;;; utility functions
;; to cope with the daemon daemoning
;; https://stackoverflow.com/questions/13981899/how-can-i-kill-all-buffers-in-my-emacs
(defun nuke-all-buffers ()
    (interactive)
      (mapc 'kill-buffer (buffer-list))
        (delete-other-windows))

;; emacs documents itself and others
;; TODO, put these things in a better path, even if it must be symlinked, this just sucks ass
(defun docsfag()
  (interactive)
  (eww-open-file
   "~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/share/doc/rust/html/book/index.html"))

(defun docsfag-cmake()
  (interactive)				;
  (eww-open-file "/home/diccu/Documents/lang/cmake/mastering-cmake/bild/html/index.html"))

(defun docsfag-sicp()
  (interactive)				;
  (eww-open-file "/home/diccu/Documents/lang/lisp/book/book.html"))

;; mild yasnippet abuse
;; create snippets on the fly from a shorthand
;; shorthands are single chars, expansion is described below 
(setq *snippet-shorthand-list*
      '((?b "\\mathbb" . 1)
	(?c "\\mathcal" . 1)
	(?f "\\frac" . 2)
	(?s "\\sum" . 0)
	(?l "\\lim" . 0)
	(?i "\\int" . 0)
	(?d "_" . 1)
	(?u "^" . 1)))

(defun shorthand-symbol (s) (cadr s))
(defun shorthand-arg-count (s) (cddr s))

(defun create-snippet-from-shorthand (short)
  "the short arg is a shorthand for a snippet, retuns a yasnippet snippet created from the shorthand"
  ;; input cleanup
  (setq short (string-clean-whitespace short))
  ;; now expand every char of the shorthand
  ;; some initial setting
  (let ((s-len (length short))
	(acc "")
	(index-in-snippet 1))
    ;; then iterate every char of the shorthand
    ;; appending the expansion to an accumulator
    (dotimes (i s-len)
      (let* ((c (aref short i))
	     (snip-description (assoc c *snippet-shorthand-list*))
	     (snip-symbol (shorthand-symbol snip-description))
	     (snip-arg-count (shorthand-arg-count snip-description)))
	(setq acc (concat acc snip-symbol))
	(dotimes (x snip-arg-count)
	  (setq acc (concat acc "{ $" (number-to-string index-in-snippet) " } "))
	  (setq index-in-snippet (1+ index-in-snippet)))))
    (concat acc "$0")))

;;; aesthetic changes
; (add-to-list 'default-frame-alist '(fullscreen . maximized)) ; (fucks with awesomewm window management)
(set-face-attribute 'default nil :family "JetBrains Mono" :height 130)

;; (require 'color-theme-sanityinc-tomorrow)

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (defun going-dark() (interactive) (color-theme-sanityinc-tomorrow-eighties))
  (defun going-light() (interactive) (color-theme-sanityinc-tomorrow-day)))

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
	doomt-themes-enable-italic t)
  (load-theme 'doom-one t)
  (doom-themes-org-config))

(add-to-list 'default-frame-alist '(undecorated . t))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/everforest-theme")
(set-face-attribute 'default nil :family "JetBrains Mono" :height 130)

(set-face-attribute 'org-level-1 nil :height 180)
(set-face-attribute 'org-level-2 nil :height 170)
(set-face-attribute 'org-level-3 nil :height 160)
(set-face-attribute 'org-level-4 nil :height 140)

(setq org-hide-emphasis-markers t)


;; clean up interface
;; https://github.com/technomancy/better-defaults/blob/master/better-defaults.el
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

;;; Here be keybinds
(global-set-key "\C-x\C-b" 'ibuffer)
(global-set-key "\C-x\C-b" 'ibuffer)

;;; extremely unelegant and must be removed once I figure out how to
;;; make my keybinds cooler somebody save me from my own incompetence
(with-eval-after-load 'c-mode
	  (define-key c-mode-map (kbd "M-q") 'neotree-toggle))
(with-eval-after-load 'c++-mode
	  (define-key c++-mode-map (kbd "M-q") 'neotree-toggle))
(with-eval-after-load 'java-mode
	  (define-key java-mode-map (kbd "M-q") 'neotree-toggle))
(with-eval-after-load 'python-mode
	  (define-key python-mode-map (kbd "M-q") 'neotree-toggle))

(with-eval-after-load 'lisp-mode
	  (define-key lisp-mode-map (kbd "M-q") 'neotree-toggle))
(with-eval-after-load 'scheme-mode
	  (define-key scheme-mode-map (kbd "M-q") 'neotree-toggle))
(with-eval-after-load 'emacs-lisp-mode
	  (define-key emacs-lisp-mode-map (kbd "M-q") 'neotree-toggle))
(with-eval-after-load 'typescript-mode
	  (define-key typescript-mode-map (kbd "M-q") 'neotree-toggle))

;; javascript repl
;; fuck my life
;; https://github.com/abicky/nodejs-repl.el
(add-hook 'js-mode-hook
	  (lambda ()
            (define-key js-mode-map (kbd "M-q") 'neotree-toggle)
            (define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
            (define-key js-mode-map (kbd "C-c C-j") 'nodejs-repl-send-line)
            (define-key js-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
            (define-key js-mode-map (kbd "C-c C-c") 'nodejs-repl-send-buffer)
            (define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
            (define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)))


;; neotree
(global-unset-key "\M-q")
(global-set-key "\M-q" 'neotree-toggle)
(global-set-key "\M-w" 'shell-command)
(global-set-key "\M-a" (lambda () (interactive) (other-window 1)))
(global-set-key "\M-A" (lambda () (interactive) (other-window -1)))

;; half stolen from https://stackoverflow.com/questions/2951797/
;; because wrap
(global-set-key "\M-$" (lambda ()
			 (interactive)
			 (when (region-active-p)
			   (insert-pair 1 ?$ ?$))))

(defun prompt-and-expand-shorthand (s)
    "S è abbreviazione di uno snippet, mo' lo genero, mo' lo espando"
  (interactive "sShorthand: ")
  (yas-expand-snippet (create-snippet-from-shorthand s)))

;; the m is for math, I would have limited it to org and latex modes but me lazy
(global-set-key (kbd "C-c m") 'prompt-and-expand-shorthand)

; evil specific keybinds
; keep "colon" placement when in normal mode on an Italian keyboard layout
(evil-define-key 'normal 'global "ç" 'evil-ex)

;; insert mode is useless before the glory of emacs mode
;; although these bindings kinda ruin everything when running in a terminal, so 
;; evil leader keybinds
(evil-set-leader 'normal (kbd "SPC"))
(evil-set-leader 'insert (kbd "M-SPC"))

(evil-define-key 'normal 'global (kbd "<leader>vs") 'split-window-right)
(evil-define-key 'normal 'global (kbd "<leader>vh") 'split-window-below)
(evil-define-key 'normal 'global (kbd "<leader>vq") 'delete-window)
(evil-define-key 'normal 'global (kbd "<leader>vw") 'delete-other-windows)

(evil-define-key 'normal 'global (kbd "<leader>q") 'neotree-toggle)
(evil-define-key 'normal 'global (kbd "<leader>w") 'shell-command)
(evil-define-key 'normal 'global (kbd "<leader>a")
  (lambda () (interactive) (other-window 1)))
(evil-define-key 'normal 'global (kbd "<leader>p") (lambda (s)
						    (interactive "sShorthand: ")
						    (evil-emacs-state)
						    (prompt-and-expand-shorthand s)))

;; memento 
;;(evil-define-key 'normal 'global
;;(kbd "<leader>sa") (kbd "i\\sum_{-\\infty}^{\\infty}e^{}"))

;; neotree and evil, movement
(evil-define-key 'normal neotree-mode-map (kbd "j") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "k") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-create-node)
(evil-define-key 'normal neotree-mode-map (kbd "d") 'neotree-delete-node)

;; neotree and evil, file management
(evil-define-key 'normal neotree-mode-map (kbd "r") 'neotree-rename-node)
(evil-define-key 'normal neotree-mode-map (kbd "c") 'neotree-copy-node)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "h") 'neotree-hidden-file-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" default))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(lsp-mode typescript-mode jedi neotree color-theme-modern minizinc-mode beacon ediprolog solarized-theme cobol-mode rust-mode haskell-tab-indent haskell-emacs company-coq vterm monokai-pro-theme acme-theme gruvbox-theme material-theme ef-themes color-theme-sanityinc-tomorrow flycheck auto-complete compat ess dracula-theme nord-theme sly sxhkdrc-mode yasnippet-snippets auctex haskell-mode goto-last-change undo-tree undo-fu evil js2-mode js-comint nodejs-repl elpy doom-themes olivetti all-the-icons org-bullets))
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
