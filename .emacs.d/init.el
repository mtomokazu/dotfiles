;; .emacs

(set-language-environment "Japanese")
;(require 'un-define)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq file-name-coding-system 'utf-8)

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

;(require 'hl-line)
;(global-hl-line-mode)
;(setq hl-line-face 'underline)

(load-library "term/bobcat")
(when (fboundp 'terminal-init-bobcat)
  (terminal-init-bobcat))

(setq inhibit-startup-message t)
(line-number-mode t)
(column-number-mode t)

(global-set-key "\C-xy" 'goto-line)
(global-set-key "\C-xw" 'what-line)

(setq backup-by-copying t)
(defun make-backup-file-name (file)
              (concat (expand-file-name "~/var/tmp")
                      "/"
                      (file-name-nondirectory file)) )

;; global variables
;(setq
; inhibit-startup-screen t
; create-lockfiles nil
; make-backup-files nil
; column-number-mode t
; scroll-error-top-bottom t
; show-paren-delay 0.5
; use-package-always-ensure t
; sentence-end-double-space nil)

;; buffer local variables
(setq-default
 indent-tabs-mode nil
 tab-width 4
 c-basic-offset 4)

;; modes
(electric-indent-mode 0)

;; global keybindings
;(global-unset-key (kbd "C-z"))

;; the package manager
(require 'package)
(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
		    ("org" . "http://orgmode.org/elpa/")
		    ;("melpa" . "http://melpa.org/packages/")
		    ("melpa" . "http://melpa.milkbox.net/packages/")
		    ("melpa-stable" . "http://stable.melpa.org/packages/")
		    ("mermalade" . "http://mermalade-repo.org/packages/"))
 package-archive-priorities '(("melpa-stable" . 1)))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;;
;; for Programming
;;
(setq show-trailing-whitespace t)
(add-hook 'before-save-hook
          (lambda ()
            (delete-trailing-whitespace)))

;;;
;;;  GNU GLOBAL
;;;
(add-to-list 'load-path "~/lib/emacs")
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
	 (local-set-key "\M-t" 'gtags-find-tag)
	 (local-set-key "\M-r" 'gtags-find-rtag)
	 (local-set-key "\M-s" 'gtags-find-symbol)
	 (local-set-key "\C-t" 'gtags-pop-stack) ))

;;
;; Scala (ENSIME)
;;
(use-package scala-mode
	     :interpreter
	     ("scala" . scala-mode))

;;
;; Groovy (ENSIME)
;;
(use-package goovy-mode
	     :interpreter
	     ("groovy" . groovy-mode))

;;
;; Perl
;;
(defalias 'perl-mode 'cperl-mode)
;(autoload 'perl-mode
;  "cperl-mode" "Alternate mode for editing Perl programs."
;  t)
(setq cperl-indent-level 4)
(setq cperl-continued-statement-offset 4)

;;
;; Ruby
;;
(setq ruby-mode-hook
      '(lambda ()
         (setq ruby-insert-encoding-magic-comment nil) ))

;;
;; Elixir
;;
(add-to-list 'load-path "~/lib/emacs/emacs-elixir")
(require 'elixir-mode)
(add-to-list 'auto-mode-alist '("\.ex$" . elixir-mode))
(add-to-list 'auto-mode-alist '("\.exs$" . elixir-mode))
(add-hook 'elixir-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)
	    (setq tab-width 2)))

;;
;;  YAML
;;
(add-to-list 'load-path "~/lib/emacs/yaml-mode")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\.yml$'" . yaml-mode))

;; eof
