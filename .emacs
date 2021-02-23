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

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )

(set-default-font "monospace-10.5")
(setq-default line-spacing 3)
(setq ring-bell-function 'ignore)
(setq confirm-kill-emacs 'y-or-n-p)
(setq-default cursor-type 'bar)
(menu-bar-mode -1)
(tool-bar-mode -1)
(delete-selection-mode 1)
(when (boundp 'scroll-bar-mode)(scroll-bar-mode 1))
(dumb-jump-mode)
(windmove-default-keybindings)


(setq frame-title-format
      '(
	(:eval
	 (let ((project-name (projectile-project-name)))
	   (unless (string= "-" project-name)
	     (format "[%s]" project-name))))
	(:eval
	 (let ((project-root (projectile-project-root)))
	   (let ((relative-to-projectile-root (file-relative-name "%b" project-root)))
	     (unless (string= "-" relative-to-projectile-root)
	       (format " %s" relative-to-projectile-root)))))
	)
      )

(require 'display-line-numbers)
(defcustom display-line-numbers-exempt-modes '(vterm-mode eshell-mode shell-mode term-mode ansi-term-mode)
  "Major modes on which to disable the linum mode, exempts them from global requirement"
  :group 'display-line-numbers
  :type 'list
  :version "green")

(defun display-line-numbers--turn-on ()
  "turn on line numbers but excempting certain majore modes defined in `display-line-numbers-exempt-modes'"
  (if (and
       (not (member major-mode display-line-numbers-exempt-modes))
       (not (minibufferp)))
      (display-line-numbers-mode)))

(global-display-line-numbers-mode)

;; WARNA THEMES===============================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#ffffff" "#f36c60" "#8bc34a" "#fff59d" "#4dd0e1" "#b39ddb" "#81d4fa" "#263238"))
 '(custom-enabled-themes (quote (deeper-blue)))
 '(custom-safe-themes
   (quote
    ("a67bc0a845bbb124e30ed389f8d593daa4448086be2709ca63f6fdefd859991a" "7922b14d8971cce37ddb5e487dbc18da5444c47f766178e5a4e72f90437c0711" "afd761c9b0f52ac19764b99d7a4d871fc329f7392dfc6cd29710e8209c691477" "edb73be436e0643727f15ebee8ad107e899ea60a3a70020dfa68ae00b0349a87" "614a8fc7db02cb99d9f1acf1297b26f8224cf80bf6c0ec31d30c431503e8b59f" "d4f8fcc20d4b44bf5796196dbeabec42078c2ddb16dcb6ec145a1c610e0842f3" "732b807b0543855541743429c9979ebfb363e27ec91e82f463c91e68c772f6e3" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" default)))
 '(ecb-options-version "2.50")
 '(fci-rule-color "#37474f")
 '(helm-buffer-max-length 80)
 '(hl-sexp-background-color "#1c1f26")
 '(package-selected-packages
   (quote
    (impatient-mode ivy rainbow-delimiters laguna-theme presentation drag-stuff flow-minor-mode yasnippet-snippets twittering-mode ecb eslint-fix exec-path-from-shell json-mode tide jsx-mode swift-mode dumb-jump rjsx-mode react-snippets ac-js2 php-auto-yasnippets php-mode vue-html-mode ac-php ggtags helm-gtags flycheck yasnippet web-mode undo-tree powerline multiple-cursors material-theme magit js2-mode highlight-indent-guides helm-projectile emmet-mode auto-complete amx)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f36c60")
     (40 . "#ff9800")
     (60 . "#fff59d")
     (80 . "#8bc34a")
     (100 . "#81d4fa")
     (120 . "#4dd0e1")
     (140 . "#b39ddb")
     (160 . "#f36c60")
     (180 . "#ff9800")
     (200 . "#fff59d")
     (220 . "#8bc34a")
     (240 . "#81d4fa")
     (260 . "#4dd0e1")
     (280 . "#b39ddb")
     (300 . "#f36c60")
     (320 . "#ff9800")
     (340 . "#fff59d")
     (360 . "#8bc34a"))))
 '(vc-annotate-very-old-color nil))
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;WEB MODE================================================================================================================== WEB MODE

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.handlebars\\'" . web-mode))
(add-to-list 'web-mode-comment-formats '("php" . "//"))
(add-to-list 'web-mode-comment-formats '("javascript" . "//"))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-script-padding 0)
  (setq web-mode-style-padding 0)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)
(setq web-mode-enable-current-element-highlight t)
(add-hook 'web-mode-hook #'emmet-mode)

;;JAVASCRIPT================================================================================================================ JAVASCRIPT
;;(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
(add-hook 'js-mode-hook 'js2-minor-mode);
(add-hook 'js2-mode-hook 'ac-js2-mode)
(add-hook 'js2-mode-hook 'emmet-mode)
(setq js2-highlight-level 3)

(add-hook 'rjsx-mode-hook
          (lambda ()
	    (setq indent-tabs-mode nil) ;;Use space instead of tab
            (setq js-indent-level 2) ;;space width is 2 (default is )
            (setq js2-strict-missing-semi-warning nil))) ;;disable the semicolon warning

;;UNDO TREE================================================================================================================= UNDO TREE
(global-undo-tree-mode)
(global-set-key (kbd "M-/") 'undo-tree-visualize)


;;POWERLINE================================================================================================================= POWERLINE
(require 'powerline)
(powerline-default-theme)

;;Projectile Helm=========================================================================================================== HELM PROJECTILE
(require 'helm-projectile)
;;(projectile-mode)
(projectile-mode +1)
(setq projectile-indexing-method 'hybrid)
;;(setq projectile-completion-system 'ivy)
(setq projectile-completion-system 'helm)
(setq projectile-switch-project-action 'helm-projectile-find-file)
(setq projectile-enable-caching t)
(helm-projectile-on)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x b") #'helm-mini)
(global-set-key (kbd "C-x f") #'helm-find)

(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;;(add-to-list 'projectile-globally-ignored-directories "node_modules")
;;add-to-list 'projectile-globally-ignored-directories "vendor")
;;(add-to-list 'projectile-globally-ignored-directories "storage")
;;(add-to-list 'projectile-globally-ignored-directories "public/adminlte")

;;YASNIPPET================================================================================================================= YASNIPPET
;;(require 'yasnippet)
;;(yas-global-mode 1)

;; (require 'php-auto-yasnippets)
;; (setq php-auto-yasnippet-php-program "~/.emacs.d/snippets/php-auto-yasnippets-master/Create-PHP-YASnippet.php")
;; (define-key php-mode-map (kbd "C-c C-y") 'yas/create-php-snippet)

;;AUTOCOMPLETE============================================================================================================== AUTOCOMPLETE
(require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")
(define-key ac-complete-mode-map "M-n" 'ac-next)
(define-key ac-complete-mode-map "M-p" 'ac-previous)
;;(define-key ac-mode-map (kbd "TAB") nil)
;;(define-key ac-completing-map (kbd "TAB") nil)
;;(define-key ac-completing-map [tab] nil)
(add-hook 'css-mode-hook       
	  (lambda ()
	    (make-local-variable 'ac-stop-words)
	    ;;(add-to-list 'ac-stop-words "bo")
	    (add-to-list 'ac-stop-words ";")))

(define-key ac-complete-mode-map "\r" nil)

;;EMMET MODE================================================================================================================ EMMET MODE
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
;;(add-hook 'emmet-mode-hook (lambda () (setq emmet-indent-after-insert t)))
;;(setq emmet-expand-jsx-className? t)

(global-set-key (kbd "C-x g") 'magit-status)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-string-face ((t (:foreground "OliveDrab3"))))
 '(linum ((t (:background "#263238" :foreground "orange"))))
 '(org-level-1 ((t (:inherit outline-1 :background "#263238" :box (:line-width 1 :color "#263238") :weight bold :height 1.3))))
 '(org-level-2 ((t (:inherit outline-2 :background "#263238" :box (:line-width 1 :color "#263238") :height 1.2))))
 '(web-mode-current-element-highlight-face ((t (:background "black" :foreground "#ffffff" :weight semi-bold)))))


;;MULTIPLE CURSORS========================================================================================================== MULTIPLE CURSORS
(require 'multiple-cursors)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'character)
(setq highlight-indent-guides-character ?\|)
(setq highlight-indent-guides-delay 0)

;;(set-face-background 'highlight-indent-guides-odd-face "darkgray")
;;(setq highlight-indent-guides-auto-odd-face-perc 15)
;;(setq highlight-indent-guides-auto-even-face-perc 15)
;;(setq highlight-indent-guides-auto-character-face-perc 20)


;;DRAG STUFF================================================================================================================== DRAG STUFF
(require 'drag-stuff)
(drag-stuff-global-mode 1)
(drag-stuff-define-keys)

;;(add-hook 'web-mode-hook #'rainbow-delimiters-mode)


