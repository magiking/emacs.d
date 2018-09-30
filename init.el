;;
;; The Rice
;; 
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") ;; I have yet to figue this one out
(setq inhibit-startup-message t)
(recentf-mode 1)
(setq recentf-max-menu-items 10)
;; disable the uglay stuff
;; (menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(show-paren-mode)
;; show in frames created with emacsclient
;; (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

;; (global-linum-mode t)
;; (setq-default indent-tabs-mode nil)
;; (setq-default tab-width 4)
;; (setq indent-line-function 'insert-tab)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))

(package-initialize)

;; Bootstrap 'use-package' from Zamansky vid.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package try
  :defer
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;;
;; theme
;;
(use-package gruvbox-theme
  :ensure t
  ;; :config
  ;; (load-theme 'gruvbox-light-medium t)
  )

(use-package base16-theme
  :ensure t
  ;; :config
  ;; (load-theme 'base16-grayscale-dark t)
  )

(use-package brutalist-theme
  :ensure t
  :config
  (load-theme 'brutalist t)
  )

;;
;; misc
;;

;; change the startup screen
(use-package dashboard
  :ensure t
  :init
  (setq dashboard-banner-logo-title "Enjoy 'ya self")
  (setq dashboard-startup-banner "~/.emacs.d/cool.png")
  (setq dashboard-items '((agenda . 5)
			  (recents  . 5)
			  (projects . 5)
			  ;; (bookmarks . 5)
			  ))
  :config
  (dashboard-setup-startup-hook)
  )


;; form feed chars as horizontal lines
(use-package page-break-lines
  :diminish
  :ensure t
  :config
  (setq global-page-break-lines-mode t))

;; short example man pages
(use-package tldr
  :ensure t)

(use-package emojify
  :ensure t)

;;
;; git
;;
(use-package magit
  :ensure t)

;;
;; org
;;
(use-package org
  :ensure t
  ;; :bind
  ;; (global-set-key (kbd "C-c c") 'org-capture)
  :config
  ;; add files to those looked at by org-agenda
  (setq org-agenda-files (list
			  "~/doc/org/gtd.org"
			  "~/doc/druk/club-sports/meeting2018-08-23.org"))
  ;; configure org capture templates
  (setq org-capture-templates
	'(("h" ;; hotkey
	   "Homework" ;; Name
	   entry ;; type
	   ;; heading type and title
	   (file+headline "~/doc/org/gtd.org" "Homework Assignments")
	   (file "~/.emacs.d/org-templates/homework-assignment.orgcaptmpl")) ;; template
	  ("t"
	   "Task"
	   entry
	   (file+headline "~/doc/org/gtd.org" "Tasks")
	   (file "~/.emacs.d/org-templates/task.orgcaptmpl"))
	  ("w"
	   "Work Task"
	   entry
	   (file+headline "~/doc/org/MSRDC.org" "Tasks")
	   (file "~/.emacs.d/org-templates/task.orgcaptmpl"))
	   )
	)
  ;; show org-agenda on startup
  ;; I think I need to define what files go into that agenda
  ;; (setq initial-buffer-choice (lambda ()
  ;; 				(org-agenda-list 1)
  ;; 				(get-buffer "*Org Agenda*")
  ;; 				(delete-other-windows)))
  )

;;
;; evil config
;;
(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "o" 'delete-other-windows    ;; vim :only      | emacs C-x 1
    "q" 'delete-window           ;; vim :close     | emacs C-x 0
    "c" 'org-capture             ;; vim n/a        | emacs C-c c
    "g" 'magit-status            ;; vim :Gstatus   | emacs C-c g if bound
    "w" 'evil-window-map         ;; vim C-w        | emacs C-w evil default
    "t" 'compile                 ;; vim :make      | emacs M-x compile
   )
  )

(use-package evil
  :ensure t
  ;; (global-evil-leader-mode) needs to be called before (evil-mode)
  ;; This allows for the leader key to be used in default buffers like
  ;; *Messages* and *Scratch*

  :after (evil-leader) 
  :init
  ;; needs to happen before `(require 'evil)`
  ;; for <Tab> cycling to work in org mode
  ;; under terminal emacs 
  (setq evil-want-C-i-jump nil) 
  ;; split behavior
  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)
  :config
  ;; need it!
  (evil-mode 1)

  ;; dired mods
  ;; vinegar bindings
  ;; ranger behavior
  (evil-define-key 'normal dired-mode-map
    "-" 'dired-jump
    "h" 'dired-jump
    "l" 'dired-find-file
    )

  (evil-define-key nil evil-normal-state-map
    ;; same as (define-key evil-normal-state-map (kbd "-") 'dired-jump)
    "-" 'dired-jump)
  )

(use-package evil-magit
  :after (magit)
  :ensure t
  )

(use-package evil-escape
  :ensure t
  :init
  (setq-default evil-escape-key-sequence ";;")
  (setq-default evil-escape-delay 0.2)
  (setq-default evil-escape-unordered-key-sequence t)
  :config
  (evil-escape-mode)
  )

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode)
  )

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1)
  )

(use-package evil-org
  :ensure t
  :config
  (evil-org-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("398bc1e483599d3a3c1c1ae3d4172f9be190c22f8653d068ff48ca9013def13e" "f376f4c51f98a91733fc41e4fa2d0f984760fc6c667510843735b4f22cb55768" "2473d6914a272b9ec16bfe7e76cad3155b6dd468bd9b367bfce55a454d2c250f" "a35c726bfa0b2c0bd92ccc014fe6c6f88027f1ec3243857eb89e1c91f9b17218" "2a8227a9bf8a351b6de5b74a556ac33b024f9bd6a09611fe7d2626bc3679339b" "b3bbb531e7878cb4efbe0e05f9fd96fb82de90c43c99186e64f3601c72887d40" "e8d3cdf006f3e55e80171e4eba28680c375333c03400b3761c1550c663285959" "0d85e76588e02674e72a7e9fb15a00654edb1225caf8dc34b2b7196442348c79" "055ff7ce38dec104a9960ed570866b879e95ff710d48d1218c328f6447779a03" "edcde825e6ca8c74d90c18c1bdabfbce47b295552643f79d4af1c5b61d469cff" "2dc478dece493e0463af5c89d07c694720c286acafbfe7f3ba3cbad2747387aa" "08ed4cd91eabbb4c7511ae0cc58c71ad8d49e389dfaae7e2e7920a1d2bd80926" "57e4d4b43056b02905773d9e296fe8d8d48d69fbe64be4b894f68614a5f9f1a6" "1955bc3ed1bd08b9faf957ee63e06c6db7b359b6042ee77d320e9c820c170daf" "e466debb2810353a676a96f13754004dec1f5dc9dad0049a3acc6555e1a5bd25" "8102e33bceaf7cf0b9575c2cc0feed9eb186076428793332f24b6c7e5d8189ad" "606750b8bdedf81354c1ab25a732695a55f0e2f4f2de93c77d02ef1daaac0ace" "24512748a34cc56c27cf8152a117370012e3d259a4b0ea4e213934f8b9e1079b" "701b9a9d3d6bd91e9d2a03d01c11e327fd2d5f16093fb0a29e90e09c171efb1c" "8269dcab821e44bb2e60c130d8c6f8c7189ea1425e32becb1778343681e10afd" "f3471cd1a4ca4f585929fc8ab9ebdee51b62bb3f01076adf140f94c92c7b1343" "a0c10191c444b2038635456716e732db6a416bb0b6d2596c6a7752174b70f80d" "e7970ce4c18d73ee384d1027231c8889ab25520457d2ab8cef88893ace4a414f" "12670281275ea7c1b42d0a548a584e23b9c4e1d2dabb747fd5e2d692bcd0d39b" "8cf1002c7f805360115700144c0031b9cfa4d03edc6a0f38718cef7b7cabe382" "c856158cc996d52e2f48190b02f6b6f26b7a9abd5fea0c6ffca6740a1003b333" "f27c3fcfb19bf38892bc6e72d0046af7a1ded81f54435f9d4d09b3bff9c52fc1" "ef98b560dcbd6af86fbe7fd15d56454f3e6046a3a0abd25314cfaaefd3744a9e" "cd4d1a0656fee24dc062b997f54d6f9b7da8f6dc8053ac858f15820f9a04a679" "7d2e7a9a7944fbde74be3e133fc607f59fdbbab798d13bd7a05e38d35ce0db8d" default)))
 '(org-agenda-files
   (quote
    ("~/doc/org/gtd.org" "~/doc/druk/club-sports/meeting2018-08-23.org")))
 '(package-selected-packages
   (quote
    (emojify projectile tldr brutalist-theme evil-magit magit gruvbox-theme evil-surround evil-commentary evil-escape which-key use-package try org-evil evil-org))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
