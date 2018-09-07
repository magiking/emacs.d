;;
;; The Rice
;; 
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") ;; I have yet to figue this one out
;; (load-theme 'gruvbox t)
(setq inhibit-startup-message t)
;; disable the uglay stuff
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(show-paren-mode)

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
  ;; (load-theme 'gruvbox-light-soft)
  )

(use-package magit
  :ensure t
  )

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
	  ("wt"
	   "Work Task"
	   (file+headline "~/doc/org/gtd.org" "Work")
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
    "o" 'delete-other-windows ;; vim :only      | emacs C-x 1
    "q" 'delete-window        ;; vim :close     | emacs C-x 0
    "c" 'org-capture          ;; vim n/a        | emacs C-c c
    "g" 'magit-status         ;; vim :Gstatus   | emacs C-c g if bound
    "w" 'evil-window-map      ;; vim C-w        | emacs C-w evil default
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
    ("f27c3fcfb19bf38892bc6e72d0046af7a1ded81f54435f9d4d09b3bff9c52fc1" "ef98b560dcbd6af86fbe7fd15d56454f3e6046a3a0abd25314cfaaefd3744a9e" "cd4d1a0656fee24dc062b997f54d6f9b7da8f6dc8053ac858f15820f9a04a679" "7d2e7a9a7944fbde74be3e133fc607f59fdbbab798d13bd7a05e38d35ce0db8d" default)))
 '(org-agenda-files
   (quote
    ("~/doc/org/gtd.org" "~/doc/druk/club-sports/meeting2018-08-23.org")))
 '(package-selected-packages
   (quote
    (evil-magit magit gruvbox-theme evil-surround evil-commentary evil-escape which-key use-package try org-evil evil-org))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
