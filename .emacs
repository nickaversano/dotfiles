;; packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; config
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(column-number-mode t)
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(display-battery-mode t)
 '(display-line-numbers-type (quote relative))
 '(electric-pair-mode t)
 '(fci-rule-color "#3C3D37")
 '(global-display-line-numbers-mode t)
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
    (ag git-link prettier-js web-mode yasnippet rainbow-delimiters auto-complete emmet-mode format-all magit use-package powerline projectile git-gutter evil monokai-theme ##)))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#1B1D1E")
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#1B1D1E" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-tab ((t (:foreground "#636363")))))

;; window
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; evil
(setq evil-want-C-u-scroll t)
(setq evil-want-C-d-scroll t)
(evil-mode 1)

;; theme
(setq monokai-background "#1B1D1E" monokai-highlight-line "#293739")
(load-theme 'monokai t)

;; projectile
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "s-t") 'projectile-find-file)
(define-key evil-normal-state-map (kbd "C-p") nil)
(define-key projectile-mode-map (kbd "C-p") 'projectile-find-file)
(setq projectile-project-search-path '("~/dev/"))

;; powerline
(powerline-default-theme)

;; git
(global-git-gutter-mode +1)

;; prettier
(add-hook 'web-mode-hook 'prettier-js-mode)

;; magit
(global-set-key (kbd "C-x g") 'magit-status)
;; emulate some fugitive shortcuts
(evil-ex-define-cmd "Gdiff" 'magit-diff-buffer-file)
(evil-ex-define-cmd "Gstatus" 'magit-status)

;; autocomplete
(ac-config-default)
(global-auto-complete-mode t)
(ac-set-trigger-key "TAB")

;; rainbow delimeters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; snippets
(yas-global-mode 1)

;; javascript (web mode)
(add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))
(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
(defun web-mode-init-hook ()
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (define-key evil-normal-state-map (kbd "F") 'prettier-js))
(add-hook 'web-mode-hook  'web-mode-init-hook)
;(setq web-mode-enable-auto-closing t)
;(setq sgml-quick-keys 'close)

;; emmet
(define-key evil-insert-state-map (kbd "C-y") 'emmet-expand-line)

;; config vars
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
; highlight current line
(global-hl-line-mode +1)
(setq vc-follow-symlinks t)
;; show matching braces
(setq show-paren-delay 0)
(show-paren-mode 1)
;; insert matching braces automatically
(electric-pair-mode 1)
(setq scroll-margin 4)
;; default to vertical splits (when opening mutliple files, e.g.)
(setq split-height-threshold nil)
(setq split-width-threshold 0)
; increase gc limit during startup
(setq gc-cons-threshold 50000000)
(add-hook 'emacs-startup-hook 'my/set-gc-threshold)
(defun my/set-gc-threshold ()
  "Reset `gc-cons-threshold' to its default value."
  (setq gc-cons-threshold 800000))

;; keybindings
(define-key evil-normal-state-map (kbd ";") #'evil-ex)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)

;; splits
(defun evil-window-vsplit-focus ()
  ;; split vertically and foucs new split
  (interactive)(evil-window-vsplit) (other-window 1))

(defun evil-window-split-focus ()
  ;; split horizontally and foucs new split
  (interactive)(evil-window-split) (other-window 1))

(define-key evil-normal-state-map (kbd "C-w \\") 'evil-window-vsplit-focus)
(define-key evil-normal-state-map (kbd "C-w C-\\") 'evil-window-vsplit-focus)
(define-key evil-normal-state-map (kbd "C-w -") 'evil-window-split-focus)
(define-key evil-normal-state-map (kbd "C-w C--") 'evil-window-split-focus)
(define-key evil-normal-state-map (kbd "C-w <right>") 'evil-window-right)
(define-key evil-normal-state-map (kbd "<right>") 'evil-window-right)
(define-key evil-normal-state-map (kbd "C-w <left>") 'evil-window-left)
(define-key evil-normal-state-map (kbd "<left>") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-w <down>") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-w <up>") 'evil-window-up)

;; toggle comment on current line
(define-key evil-normal-state-map (kbd "C-;") 'comment-line)

;; scrolling
(define-key evil-normal-state-map (kbd "C-e") (lambda() (interactive) (evil-scroll-line-down 16)))
(define-key evil-normal-state-map (kbd "C-y") (lambda() (interactive) (evil-scroll-line-up 16)))

;; M-x
(define-key evil-normal-state-map (kbd "<s-escape>") 'execute-extended-command)
(define-key evil-normal-state-map (kbd "<s-x>") 'execute-extended-command)

;; tabs
; START TABS CONFIG
;; Create a variable for our preferred tab width
(setq custom-tab-width 2)

;; Two callable functions for enabling/disabling tabs in Emacs
(defun disable-tabs ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode nil)
  (setq tab-width custom-tab-width))
(defun enable-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

(add-hook 'prog-mode-hook 'disable-tabs)

;; Language-Specific Tweaks
(setq-default python-indent-offset custom-tab-width) ;; Python
(setq-default js-indent-level custom-tab-width)      ;; Javascript

;; Making electric-indent behave sanely
(setq-default electric-indent-inhibit t)

;; Make the backspace properly erase the tab instead of
;; removing 1 space at a time.
(setq-default backward-delete-char-untabify-method 'hungry)
(setq backward-delete-char-untabify-method 'hungry)

;; (OPTIONAL) Shift width for evil-mode users
;; For the vim-like motions of ">>" and "<<".
(setq-default evil-shift-width custom-tab-width)
; END TABS CONFIG
(electric-indent-mode +1)

;; whitespace
(setq-default fill-column 80)
(add-hook 'text-mode-hook 'auto-fill-mode)

(setq-default whitespace-line-column 80)
(setq whitespace-style '(face empty tabs tab-mark trailing))
;; (OPTIONAL) Visualize tabs as a pipe character - "|"
(setq whitespace-display-mappings
  '((tab-mark 9 [124 9] [92 9]))) ; 124 is the ascii ID for '\|'
(global-whitespace-mode t)

;; leader key
(define-prefix-command 'leader-map)
(define-key evil-normal-state-map (kbd "SPC") leader-map)
(define-key leader-map "b" 'list-buffers)
(define-key leader-map "q" 'evil-quit)
(define-key leader-map "l" 'run-current-file)

;; run file
(defun run-current-file ()
  (interactive)
  (when (buffer-modified-p) (save-buffer))
  (when (not (buffer-file-name)) (save-buffer))
  (let* (
      (suffix-map '(
        ("php" . "php")
        ("py" . "python")
        ("rb" . "ruby")
        ("js" . "node")
        ("mjs" . "node --experimental-modules")
        ("ml" . "ocaml")
        ("ts" . "tsc")
        ("go" . "go run")
        ("sh" . "bash")
        ("lisp" . "sbcl --script")
        ("rust" . "cargo run")
        ("java" . "javac")
      ))
      (fname (buffer-file-name))
      (fext (file-name-extension fname))
      (cmd-name (cdr (assoc fext suffix-map)))
      (cmd-str (concat cmd-name " " fname))
      (fn-name (concat "run-current-" fext "-file"))
      (buf "*Output*"))
    (get-buffer-create buf)
    (unless (run-hook-with-args-until-success 'run-current-file fext)
      (if cmd-name
        (shell-command cmd-str buf)
        (error "No recognized program or function to run this file.")))
    (display-buffer buf)
    (with-current-buffer buf (special-mode))
  ))