(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(package-initialize)
;(package-refresh-contents)
;(let ((muh-packages '(
;		      ;; fundamental
;		      evil
;		      neotree
;		      color-theme-modern
;		      ;; almost fundamental
;		      flycheck
;		      auto-complete
;		      ;; colours
;		      color-theme-modern
;		      dracula-theme
;		      solarized-theme
;		      ;; ides
;		      sly
;		      geiser
;		      geiser-racket
;		      ess
;		      ediprolog
;		      auctex
;		      ;; language support
;		      sxhkdrc-mode
;		      ;; utilities
;		      beacon
;		      ;; this is where we get stupid
;		      yasnippet
;		      yasnippet-snippets
;		      )))
;  (mapc (lambda (pkg)
;	  (unless (package-installed-p pkg)
;	    (package-install pkg)))
;	muh-packages))

;;; settings for the packages
;;; I have yet to learn use-package

(require 'evil)
(evil-mode 1)

;; neotree
(require 'neotree)
(setq neotree-smart-open t)

;; flycheck
(require 'flycheck)
(global-flycheck-mode)

;; autocomplete
(require 'auto-complete)
(ac-config-default)
(setq ac-auto-start 4)
(define-key ac-completing-map "\r" nil)

;; autocomplete / ess
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
(add-hook 'org-mode-hook (lambda () (progn
					(auto-fill-mode)
					(setq truncate-lines nil)
					(setq truncate-partial-width-windows nil)
					(set-fill-column 90))))

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
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;; other language settings
(setq inferior-lisp-program "sbcl")
;; just install sbcl from sourceforge like a fucking windows user
;; becuase the dnf package is fucking segfaulting, god knows why
;; thank you fedora, thank you kindly, dickwit
(setq scheme-program-name "racket")
(setq prolog-system 'swi)
(modify-coding-system-alist 'file "\\.tex\\'" 'utf-8)

;;; personal preferences, convenience, and sanity
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq ring-bell-function 'ignore)
(setq c-basic-offset 4)

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

;; mild yasnippet abuse
;; although abuse is often the intended use, it's emacs after all
(setq *shorthand-snippet-alist*
      '((?b . "\\mathbb")
	(?c . "\\mathcal")
	(?s . "\\sum")
	(?l . "\\lim")
	(?i . "\\int")
	(?d . "_")
	(?u . "^")))
;; shorthands for latex symbols
;; becuase I ain't making all those snippets for all the possible uses
;; so we're gonna do le generate
(defun create-snippet-from-shorthand (short)
  "Translates a shortened version of a snippet into something yasnippet can expand."
  ;; input cleanup
  (setq short (string-clean-whitespace short))
  (let ((s-len (length short))
	(acc ""))
    (dotimes (i s-len)
      (let ((c (aref short i))
	    (index-in-snippet (+ i 1)))
	(setq acc
	      (concat acc
		      (cdr (assoc c *shorthand-snippet-alist*))
		      "{ $" (number-to-string index-in-snippet) " } "))))
    (concat acc "$0")))

;;; aesthetic changes
; (add-to-list 'default-frame-alist '(fullscreen . maximized)) ; (fucks with awesomewm window management)
(set-face-attribute 'default nil :family "JetBrains Mono" :height 130)

;; color themes
;; load
(add-to-list 'custom-theme-load-path
	     (file-name-as-directory "~/.emacs.d/elpa/color-theme-modern"))
(add-to-list 'custom-theme-load-path
	     (file-name-as-directory "~/.emacs.d/elpa/dracula-theme"))
(add-to-list 'custom-theme-load-path
	     (file-name-as-directory "~/.emacs.d/elpa/"))
(add-to-list 'custom-theme-load-path
	     (file-name-as-directory "~/.emacs.d/themes/everforest-theme/"))
(add-to-list 'custom-theme-load-path
	     (file-name-as-directory "~/.emacs.d/themes/"))
(setq muh-dark-theme 'everforest-hard-dark)
(setq muh-light-theme 'everforest-hard-light)
;;(setq catppuccin-flavor 'macchiato)
(defun going-dark ()
  (interactive)
  (disable-theme muh-light-theme)
  (load-theme muh-dark-theme t t)
  (enable-theme muh-dark-theme))
(defun going-light ()
  (interactive)
  (disable-theme muh-light-theme)
  (load-theme muh-light-theme t t)
  (enable-theme muh-light-theme))
(going-dark)
;; Backup themes, dracula, midnight, clarity, cobalt, solarized-dark, deep-blue, catppuccin
;; aalto-light for light mode

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

;; neotree
(global-set-key "\M-q" 'neotree-toggle)
(global-set-key "\M-w" 'shell-command)
(global-set-key "\M-a" (lambda () (interactive) (other-window 1)))

;; half stolen from https://stackoverflow.com/questions/2951797/
;; because wrap
(global-set-key "\M-$" (lambda ()
			 (interactive)
			 (when (region-active-p)
			   (insert-pair 1 ?$ ?$))))

;; da rifare

(defun prompt-and-expand-shorthand (s)
    "S è abbreviazione di uno snippet, mo' lo genero, mo' lo espando"
  (interactive "sShorthand: ")
  (yas-expand-snippet (create-snippet-from-shorthand s)))

;; the m is for math
(global-set-key (kbd "C-c m") 'prompt-and-expand-shorthand)

;; evil specific keybinds
;; keep "colon" placement when in normal mode on an Italian keyboard layout
(evil-define-key 'normal 'global "ç" 'evil-ex)

;; who needs insert mode when you can have the power of God and anime on your side?
;; mostly carelessly scavanged and frankensteined from evil/simple.el code
;; but it works
(evil-define-key 'normal 'global "i" 'evil-emacs-state)
(evil-define-key 'normal 'global "a"
  (lambda () (interactive)
    (forward-char)
    (evil-emacs-state)))
(evil-define-key 'normal 'global "I"
  (lambda () (interactive)
    (evil-first-non-blank)
    (evil-emacs-state)))
(evil-define-key 'normal 'global "A"
  (lambda () (interactive)
    (move-end-of-line nil)
    (evil-emacs-state)))
(evil-define-key 'normal 'global "O"
  (lambda () (interactive)
    (move-beginning-of-line nil)
    (open-line 1)
    (indent-according-to-mode)
    (evil-emacs-state)))
(evil-define-key 'normal 'global "o"
  (lambda () (interactive)
    (move-end-of-line 1)
    (insert "\n")
    (indent-according-to-mode)
    (evil-emacs-state)))
(evil-define-key 'emacs 'global (kbd "<escape>") 'evil-normal-state)

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("750d7a59c8d5f1e7afd6cdecbed71fe1071633c4d8ed0ff5cce39bde55310797" "51d164fa3e9ca7595ef2646114b0c0a681b6cfadd4093dd1ef4b8ae31a188889" "37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8" "45482e7ddf47ab1f30fe05f75e5f2d2118635f5797687e88571842ff6f18b4d5" default))
 '(inhibit-startup-screen t)
 '(org-confirm-babel-evaluate nil)
 '(org-format-latex-options
   '(:foreground default :background default :scale 1.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
		 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(package-selected-packages
   '(haskell-emacs haskell-tab-indent haskell-mode rust-mode auctex yasnippet-snippets yasnippet cobol-mode sxhkdrc-mode solarized-theme ediprolog beacon sly nord-theme minizinc-mode dracula-theme ess geiser-racket geiser auto-complete flycheck color-theme-modern neotree evil))
 '(warning-suppress-types '((comp) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
