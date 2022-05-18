(require 'package)
;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"));;geiser
;(package-initialize) (package-refresh-contents)
;(unless (package-installed-p 'evil) (package-install 'evil))
;(unless (package-installed-p 'neotree) (package-install 'neotree))
;(unless (package-installed-p 'use-package) (package-install 'use-package))
;(unless (package-installed-p 'flycheck) (package-install 'flycheck))
;(unless (package-installed-p 'evil-org) (package-install 'evil-org))
;(unless (package-installed-p 'auto-complete) (package-install 'auto-complete))

;;require packages and some defaults with the packages
;currently too lazy to spend two minutes learning use-package
(require 'evil) (evil-mode 1)
(require 'neotree) (setq neotree-smart-open t)
(require 'flycheck) (global-flycheck-mode)
(require 'auto-complete)
(ac-config-default)
(setq ac-auto-start 4)
(define-key ac-completing-map "\r" nil)

(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)

;;convenience and sanity
(setq scroll-conservatively most-positive-fixnum)
(setq ring-bell-function 'ignore)
(setq make-backup-files nil)
(setq auto-save-default nil)
(menu-bar-mode nil)
(show-paren-mode t)
;blaitant violation of the DRY principle, but I don't want a defun in my .emacs
(add-hook 'latex-mode-hook (lambda () (progn
					(auto-fill-mode -1)
					(setq truncate-lines t)
					(setq truncate-partial-width-windows t))))
(add-hook 'org-mode-hook (lambda () (progn
					(auto-fill-mode -1)
					(setq truncate-lines t)
					(setq truncate-partial-width-windows t))))
(modify-coding-system-alist 'file "\\.tex\\'" 'utf-8)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;aesthetic changes
(set-face-attribute 'default nil :family "JetBrains Mono" :height 125)
(add-to-list 'custom-theme-load-path
	     (file-name-as-directory "C:\\Users\\biggu\\AppData\\Roaming\\.emacs.d"))
(load-theme 'railscast t t)
(enable-theme 'railscast)

;https://github.com/technomancy/better-defaults/blob/master/better-defaults.el
(unless (eq window-system 'ns)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

(setq c-basic-offset 4)

;;Custom keybinds, reduce Control_R supremacy
(global-set-key "\M-q" 'neotree-toggle)
(global-set-key "\M-w" 'shell-command)
(global-set-key "\M-a" (lambda () (interactive) (other-window 1)))

;;evil specific custom keybinds
;;absolutely I M P E R A T I V E, Alonzo Church is judging you
(evil-define-key 'insert org-mode-map (kbd "TAB") 'org-cycle)
(evil-set-leader 'normal (kbd "SPC"))
(evil-set-leader 'insert (kbd "M-SPC"))
(evil-define-key 'normal 'global (kbd "<leader>vs") 'split-window-right)
(evil-define-key 'normal 'global (kbd "<leader>vq") 'delete-window)
(evil-define-key 'normal 'global (kbd "<leader>vw") 'delete-other-windows)

(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "h") 'neotree-hidden-file-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)

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
 '(inhibit-startup-screen t)
 '(package-selected-packages '(slime geiser-racket geiser evil))
 '(send-mail-function 'mailclient-send-it))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
