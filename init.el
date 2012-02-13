;; turn off welcome screen
(setq inhibit-startup-message t) 

;; use C-h as backspace key
(global-set-key "\C-h" 'backward-delete-char)

;; turn on fancy prompts in the shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; leave a breadcrumb trail
(defun mo-insert-find-breadcrumb ()
 (interactive)
 (setq current-point (point))
 (goto-char (point-min))
 (if (search-forward ";;breadcrumb" nil t) ()
   (progn
     (goto-char current-point)
     (insert ";;breadcrumb"))))

(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-classic)))


(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(word-wrap t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(global-linum-mode 1)
(add-to-list 'load-path "~/.emacs.d/color-theme.el")

;;(setq load-path (append (list (expand-file-name "~/.emacs.d/js2")) load-path))
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; the following lines enable modes for symfony projects
;;(add-to-list 'load-path "~/.emacs.d/eproject")
;;(require 'eproject)
;;(load "~/.emacs.d/nxhtml/autostart.el")
;;(setq mumamo-background-colors nil) 
;;(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))
;;(add-to-list 'auto-mode-alist '("\\.twig$" . django-html-mumamo-mode))
;; auto-load django-html-mumano for twig files
;; (setq auto-mode-alist (cons '("\\.twig$" . django-html-mumano-mode) auto-mode-alist))

(delete-selection-mode t)

;; set frame size and position
(set-frame-size (selected-frame) 199 51)
(set-frame-position (selected-frame) 50 80)

;; fix Copy/Paste Clipboard Issues:
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)
;;(global-set-key [(shift delete)] 'clipboard-kill-region)
;;(global-set-key [(control insert)] 'clipboard-kill-ring-save)
;;(global-set-key [(shift insert)] 'clipboard-yank)

;;set to php-mode
(require 'php-mode)

;; set default tab width to 4 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;; customize c-default style variable
(setq-default c-basic-offset 4)

(add-to-list 'load-path "~/.emacs.d/symfony.el")
(add-to-list 'load-path "~/.emacs.d/sf.el")
(require 'sf)

;;;;;;;;;;;;;;;;;;;;
;; systems
;;;;;;;;;;;;;;;;;;;;
(defconst win32
  (eq system-type 'windows-nt)
  "Are we running on Win32 system?")
(defconst linux
  (eq system-type 'gnu/linux)
  "Are we running on linux system?")
(defconst graf
  (not (eq window-system 'nil))
  "Are we running on Windows system?")

;;;;;;;;;;;;;;;;;;;;
;; set up unicode
;;(prefer-coding-system       'utf-8)
;; This from a japanese coder.
;;(setq default-buffer-file-coding-system 'utf-8)
;; From Emacs wiki
;;(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(when linux
  (set-clipboard-coding-system 'koi8-u)
  (set-default-coding-systems 'koi8-u)
  (set-keyboard-coding-system 'koi8-u))
(when win32
  ;; MS Windows clipboard is UTF-16LE 
  (set-clipboard-coding-system 'utf-16le-dos)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;WANDERLUST EMAIL CLIENT;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; wanderlust
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;; IMAP
(setq elmo-imap4-default-server "imap.gmail.com")
(setq elmo-imap4-default-user "robdoherty2@gmail.com") 
(setq elmo-imap4-default-authenticate-type 'clear) 
(setq elmo-imap4-default-port '993)
(setq elmo-imap4-default-stream-type 'ssl)

(setq elmo-imap4-use-modified-utf7 t) 

;; SMTP
(setq wl-smtp-connection-type 'starttls)
(setq wl-smtp-posting-port 587)
(setq wl-smtp-authenticate-type "plain")
(setq wl-smtp-posting-user "robdoherty2")
(setq wl-smtp-posting-server "smtp.gmail.com")
(setq wl-local-domain "gmail.com")

(setq wl-default-folder "%inbox")
(setq wl-default-spec "%")
(setq wl-draft-folder "%[Gmail]/Drafts") ; Gmail IMAP
(setq wl-trash-folder "%[Gmail]/Trash")

(setq wl-folder-check-async t) 

(setq elmo-imap4-use-modified-utf7 t)

(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))