;; add package archive links
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
;; enable ido-mode
(require 'ido)
(ido-mode t)
;; color shell text
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(el-get 'sync)

;;enable jedi auto-complete for python
(add-hook 'python-mode-hook 'auto-complete-mode)
(add-hook 'python-mode-hook 'jedi:ac-setup)

;; ipython
(add-hook 'python-mode-hook 'ein:connect-to-default-notebook)

;; load paths
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.mustache$" . html-mode))
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/scala-mode/")
(require 'scala-mode-auto)
(add-hook 'scala-mode-hook
	  '(lambda ()
	     (scala-mode-feature-electric-mode)
	     ))
(require 'scala-mode)
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
(add-to-list 'load-path "~/.emacs.d/site-lisp/ensime/elisp/")
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; turn off welcome screen
(setq inhibit-startup-message t) 

;; set cursor type
;;(setq-default cursor-type 'box)
(require 'cursor-chg)  ; Load this library
(change-cursor-mode 1) ; On for overwrite/read-only/input mode
(toggle-cursor-type-when-idle 1) ; On when idle

;; set default font
(set-default-font "Monospace-7.5")

;; show trailing whitespaces
(setq show-ws-toggle-show-trailing-whitespace t)

;; use C-h as backspace key
(global-set-key "\C-h" 'backward-delete-char)

;; when in gui mode
(defun zenburn-init ()
  (load-theme 'zenburn t)
  )

(when (display-graphic-p)
  (set-frame-size (selected-frame) 300 95)
  (add-hook 'after-init-hook 'zenburn-init))

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; python mode use tabs instead of spaces
(add-hook 'python-mode-hook
	  (lambda () (setq indent-tabs-mode t)
	    (setq python-indent 8)))

;; YAML mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; JAVA STUFF ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; java mode use tabs
(add-hook 'java-mode-hook
	  (lambda () ()
	    (setq c-basic-offset 4
		  tab-width 4
		  indent-tabs-mode t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; function for fullscreen
(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
					   nil
					 'fullboth)))
(global-set-key [(meta return)] 'toggle-fullscreen)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default)))
 '(js-indent-level 8)
 '(js2-basic-offset 8)
 '(js2-cleanup-whitespace t)
 '(speedbar-default-position (quote left-right))
 '(speedbar-frame-parameters (quote ((minibuffer) (width . 35) (border-width . 0) (menu-bar-lines . 0) (tool-bar-lines . 0) (unsplittable . t) (left-fringe . 0))))
 '(speedbar-mode-hook nil)
 '(speedbar-select-frame-method (quote (quote attached)))
 '(speedbar-visiting-file-hook nil)
 '(word-wrap t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-linum-mode 1)

(delete-selection-mode t)

;; fix Copy/Paste Clipboard Issues:
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)

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
