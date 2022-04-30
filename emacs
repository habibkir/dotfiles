(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages"))
;;for geiser
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(package-initialize)

;;now, from evil mode's github
;;uncomment if you want
;;(package-refresh-contents)

(setq make-backup-files nil)
(setq auto-save-default nil)

;;aesthetic changes
(setq default-frame-alist '((font . "Consolata-14")))
(setq scroll-conservatively most-positive-fixnum)
(show-paren-mode t)
;;enable railscast theme
(add-to-list 'custom-theme-load-path (file-name-as-directory "~/.emacs.d/replace-colorthemes"))
(load-theme 'railscast t t)
(enable-theme 'railscast)

;;M-shift-1 is already taken by the i3 keybind and I'm too used to the i3 keybind
(global-set-key "\M-w" 'shell-command)

;;install evil
(unless (package-installed-p 'evil) (package-install 'evil))
(require 'evil)
(evil-mode 1)

;;install slime
;;made this part up, plz don't kill me daddy rms
(unless (package-installed-p 'slime) (package-install 'slime))
(require 'slime)
(setq inferior-lisp-program "clisp")

;;neotree (too lazy to figure treemacs out)
(add-to-list 'load-path "~/.emacs.d/neotree")
(require 'neotree)
(global-set-key "\M-q" 'neotree-toggle);f8 is too far for my taste, vim makes my fingers lazy

;;opzioni per neotree (copiate senza pudore dalla wiki)
;;apri neotree in modo che il file su cui eri sia visibile e figo
(setq neotree-smart-open t);;cazzo odio la parola smart

;;neotree con evil mode (spudoratamente dalla wiki, pure questo)
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "j") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "k") 'neotree-previous-line)

(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-create-node)
(evil-define-key 'normal neotree-mode-map (kbd "c") 'neotree-create-node)
(evil-define-key 'normal neotree-mode-map (kbd "d") 'neotree-delete-node)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)

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
