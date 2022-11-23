(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))

;; I forgot what a macro is, behold, and despair
;(package-initialize)
;(package-refresh-contents)
;; foundational
;(unless (package-installed-p 'evil) (package-install 'evil))
;(unless (package-installed-p 'neotree) (package-install 'neotree))
;(unless (package-installed-p 'color-theme-modern) (package-install 'color-theme-modern))
;(unless (package-installed-p 'dracula-theme) (package-install 'dracula-theme))
;(unless (package-installed-p 'nord-theme) (package-install 'nord-theme))
;; almost foundational
;(unless (package-installed-p 'flycheck) (package-install 'flycheck))
;(unless (package-installed-p 'auto-complete) (package-install 'auto-complete))
;; ides and shit
;(unless (package-installed-p 'sly) (package-install 'sly))
;(unless (package-installed-p 'geiser) (package-install 'geiser))
;(unless (package-installed-p 'geiser-racket) (package-install 'geiser-racket))
;(unless (package-installed-p 'ess) (package-install 'ess))
;(unless (package-installed-p 'minizinc-mode) (package-install 'minizinc-mode))
;; minor
;(unless (package-installed-p 'beacon) (package-install 'beacon))

;require packages and some defaults with the packages
;currently too lazy to spend two minutes learning use-package
(require 'evil) (evil-mode 1)
(require 'neotree) (setq neotree-smart-open t)
(require 'flycheck) (global-flycheck-mode)

(require 'color-theme-modern)
(require 'dracula-theme)
(require 'nord-theme)

(require 'sly)
(require 'geiser)
(require 'geiser-racket)
(setq inferior-lisp-program "clisp") ;sbcl fa un po' male
(setq scheme-program-name "racket")

(require 'ess) (setq ac-use-quick-help nil)
;(require 'minizinc-mode) (add-to-list 'auto-mode-alist '("\\.mzn\\'" . minizinc-mode))

(require 'org-tempo)
	 
(add-to-list 'org-preview-latex-process-alist 'dvipng)
;;; copied from https://plantuml.com/emacs
(setq org-plantuml-jar-path (expand-file-name "/home/diccu/uml/plantuml.jar"))
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
(add-to-list 'org-src-lang-modes '("lisp" . lisp))
(add-to-list 'org-src-lang-modes '("python" . python))
(add-to-list 'org-src-lang-modes '("scheme" . scheme))

(require 'ob-python)
(require 'ob-lisp)
(require 'ob-scheme)

(setq org-babel-lisp-eval-fn 'sly-eval)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (plantuml . t)
   (python . t)
   (lisp . t)
   (scheme . t)))

(require 'auto-complete)
(ac-config-default)
(setq ac-auto-start 4)
(define-key ac-completing-map "\r" nil)

(require 'beacon)
(beacon-mode 1)

;;convenience and sanity
(setq scroll-conservatively most-positive-fixnum)
(setq ring-bell-function 'ignore)
(setq make-backup-files nil)
(setq auto-save-default nil)
(menu-bar-mode nil)
(show-paren-mode t)

;; from https://stackoverflow.com/questions/13981899/how-can-i-kill-all-buffers-in-my-emacs
;; to cope with the daemon daemoning
(defun nuke-all-buffers ()
    (interactive)
      (mapcar 'kill-buffer (buffer-list))
        (delete-other-windows))
;; (global-set-key (kbd "C-x K") 'nuke-all-buffers)
(defun docsfag()
  (interactive)
  (eww-open-file
   "~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/share/doc/rust/html/book/index.html"))

(defun docsfag-cmake()
  (interactive)
  (eww-open-file "/home/diccu/Documents/lang/cmake/mastering-cmake/bild/html/index.html"))


;blaitant violation of the DRY principle, but I don't want a defun in my .emacs
(add-hook 'org-mode-hook (lambda () (progn
					(auto-fill-mode)
					(setq truncate-lines nil)
					(setq truncate-partial-width-windows nil)
					(set-fill-column 90))))

(modify-coding-system-alist 'file "\\.tex\\'" 'utf-8)

;;personal preferences
(setq c-basic-offset 4)


;;aesthetic changes

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(set-face-attribute 'default nil :family "JetBrains Mono" :height 130)

(add-to-list 'custom-theme-load-path (file-name-as-directory "~/.emacs.d/elpa/color-theme-modern"))
(add-to-list 'custom-theme-load-path (file-name-as-directory "~/.emacs.d/elpa/dracula-theme"))
(add-to-list 'custom-theme-load-path (file-name-as-directory "~/.emacs.d/elpa/"))
;; backup themes, dracula, midnight, clarity, cobalt
;; aalto-light for light mode
(let ((theme 'railscast)) ; pugno in un occhio, ma funziona al sole
  (load-theme theme t t)
  (enable-theme theme))

;https://github.com/technomancy/better-defaults/blob/master/better-defaults.el
(unless (eq window-system 'ns)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))


;; keybinds, and "a lot" of them (most likely rookie numbers)
(global-set-key "\C-x\C-b" 'ibuffer)

(global-set-key "\M-q" 'neotree-toggle)
(global-set-key "\M-w" 'shell-command)
(global-set-key "\M-a" (lambda () (interactive) (other-window 1)))
(evil-define-key 'insert prolog-mode-map (kbd "TAB")
  (lambda () (interactive) (other-window 1)))
(evil-define-key 'normal prolog-mode-map (kbd "TAB")
  (lambda () (interactive) (other-window 1)))

;;evil specific custom keybinds
(evil-define-key 'normal 'global "ç" 'evil-ex);italian keyboard, too used to : placement on english keyboard
(evil-set-leader 'normal (kbd "SPC"))
(evil-set-leader 'insert (kbd "M-SPC"))
(evil-define-key 'normal 'global (kbd "<leader>q") 'neotree-toggle)
(evil-define-key 'normal 'global (kbd "<leader>w") 'shell-command)
(evil-define-key 'normal 'global (kbd "<leader>a") (lambda () (interactive) (other-window 1)))
;(evil-define-key 'normal 'global (kbd "<leader>sa") (kbd "i\\sum_{-\\infty}^{\\infty}e^{}")) ;fallo poi per argenti

;;absolutely I M P E R A T I V E, Alonzo Church is judging yo  u
(evil-define-key 'insert org-mode-map (kbd "TAB") 'org-cycle)
(evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle)
(evil-define-key 'normal 'global (kbd "<leader>vs") 'split-window-right)
(evil-define-key 'normal 'global (kbd "<leader>vh") 'split-window-below)
(evil-define-key 'normal 'global (kbd "<leader>vq") 'delete-window)
(evil-define-key 'normal 'global (kbd "<leader>vw") 'delete-other-windows)

(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "h") 'neotree-hidden-file-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
;(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)

(evil-define-key 'normal neotree-mode-map (kbd "j") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "k") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-create-node)
(evil-define-key 'normal neotree-mode-map (kbd "d") 'neotree-delete-node)
(evil-define-key 'normal neotree-mode-map (kbd "r") 'neotree-rename-node)
(evil-define-key 'normal neotree-mode-map (kbd "c") 'neotree-copy-node)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("45482e7ddf47ab1f30fe05f75e5f2d2118635f5797687e88571842ff6f18b4d5" default))
 '(inhibit-startup-screen t)
 '(org-format-latex-options
   '(:foreground default :background default :scale 1.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
		 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(package-selected-packages
   '(beacon sly nord-theme minizinc-mode dracula-theme ess geiser-racket geiser auto-complete flycheck color-theme-modern neotree evil))
 '(warning-suppress-types '((comp) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
