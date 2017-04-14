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

;;;  twittering-mode
;;;
(add-to-list 'load-path "~/lib/emacs/twittering-mode/")
(require 'twittering-mode)

;;;
;;;  GNU GLOBAL
;;;
(setq load-path
      (cons "~/lib/emacs" load-path))
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
	 (local-set-key "\M-t" 'gtags-find-tag)
	 (local-set-key "\M-r" 'gtags-find-rtag)
	 (local-set-key "\M-s" 'gtags-find-symbol)
	 (local-set-key "\C-t" 'gtags-pop-stack) ))

;;;
;;;  auto-install
;;;
;(require 'auto-install)
;(setq auto-install-directory "~/.emacs.d/auto-install/")
;(auto-install-update-emacswiki-package-name t)
;(auto-install-compatibility-setup)             ; 互換性確保

;;;
;;;  anything.el
;;;
;(if (> emacs-major-version 21)
;    (require 'anything)
;    ;(require 'anything-config)
;)



;;;
;;;  auto-complete
;;;
(add-to-list 'load-path "~/lib/emacs/auto-complete")
(require 'auto-complete)
(require 'auto-complete-config)    ; 必須ではないですが一応
(global-auto-complete-mode t)
(setq ac-modes (append ac-modes '(groovy-mode)))
;;;
;;;  Groovy
;;;
(autoload 'groovy-mode "groovy-emacs-modes-master/groovy-mode" "Groovy editing mode." t)
;(autoload 'groovy-mode "Emacs-Groovy-Mode/groovy-mode" "Groovy editing mode." t)
;(autoload 'groovy-mode "groovy-mode" "Groovy editing mode." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.gradle$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("\.groovy$" . groovy-mode))
;(setq groovy-mode-hook
;      '(lambda ()
;         (setq tab-width 4)
;	 (setq indent-tabs-mode nil)
;	 (c-set-style "stroustrup")
;	 ;(c-set-style "linux")
;	 (setq c-indent-level 4)
;	 ;(setq c-label-offset 0)
;	 (setq c-tab-always-indent t)) )
(setq groovy-mode-hook
      '(lambda ()
         (setq indent-tabs-mode nil)
         (setq c-indent-level 4)
         (setq c-continued-brace-offset 4)
         (setq c-continued-statement-offset 4)
         (setq c-brace-offset -4)
         (setq c-label-offset -4)
         (setq c-tab-always-indent t)) )
(setq c-basic-offset 4)

;;(defface my-face-r-1 '((t (:background "gray15"))) nil)
(defface my-face-b-1 '((t (:background "gray"))) nil)
(defface my-face-b-2 '((t (:background "gray26"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
;;(defvar my-face-r-1 'my-face-r-1)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)

;(defadvice font-lock-mode (before my-font-lock-mode ())
;  (font-lock-add-keywords
;   major-mode
;   '(("\t" 0 my-face-b-2 append)
;     ("　" 0 my-face-b-1 append)
;     ("[ \t]+$" 0 my-face-u-1 append)
;     ;;("[\r]*\n" 0 my-face-r-1 append)
;     )))
;(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
;(ad-activate 'font-lock-mode)

;(load "saveplace")
;(setq-default save-place t)
(when (require 'saveplace nil t)
  (setq-default save-place t)
  (setq save-place-file "~/.emacs.d/saved-places"))

;;
;; howm
;;
;(add-to-list 'load-path "/usr/share/emacs/site-lisp/howm/")
(add-to-list 'load-path "~/lib/emacs/howm")
(setq howm-menu-lang 'ja)
;(setq howm-directory "/mnt/win1/home/howm")
(setq howm-directory "~/howm")
(global-set-key "\C-c,," 'howm-menu)
(autoload 'howm-menu "howm-mode" "Hitori Otegaru Wiki Modoki" t)

(setq howm-menu-lang 'ja)
;(setq howm-file-name-format "%Y/%m/%Y_%m_%d.howm")
(setq howm-file-name-format "%Y/%Y_%m.howm")

;; 一ファイル複数メモのとき, 新規メモはファイルの先頭へ
(setq howm-prepend t)

;; メニューファイルを直接指定
;(setq howm-menu-top nil)
;(setq howm-menu-file "0000-00-00-000000.howm")
(setq howm-menu-file "0000-00.howm")

;; 予定とToDoの表示数
(setq howm-menu-schedule-days-before 0)  ;; 今日から
(setq howm-menu-schedule-days 14)  ;; 2週間後まで
(setq howm-menu-todo-num 50)


;;
;;  font-lock
;;
;(set-face-foreground 'font-lock-comment-face "violet")
;(set-face-foreground 'font-lock-comment-face "#556b2f")
;(set-face-foreground 'font-lock-comment-face "gray")
;(set-face-foreground 'font-lock-string-face "coral")
;(set-face-foreground 'font-lock-keyword-face "blue")
;(set-face-foreground 'font-lock-function-name-face "blue")
(set-face-foreground 'font-lock-variable-name-face "blue")
;(set-face-foreground 'font-lock-type-face "blue")
;(set-face-foreground 'font-lock-builtin-face "blue")

;;
;;  Anthy
;;
;(add-to-list 'load-path "/usr/share/emacs/site-lisp/anthy")
;(load-file "/usr/share/emacs/site-lisp/anthy/leim-list.el")
(add-to-list 'load-path "~/lib/emacs/anthy")
(load-file "~/lib/emacs/anthy/leim-list.el")

(load-library "anthy")
(setq default-input-method "japanese-anthy")
;(global-set-key "\C-o" 'anthy-mode)
(global-set-key "\C-o" 'toggle-input-method)
;(anthy-load-hiragana-map anthy-alt-char-map)

;; eof
(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )

;;
;;  cperl-mode
;;
(defalias 'perl-mode 'cperl-mode)
;(autoload 'perl-mode
;  "cperl-mode" "Alternate mode for editing Perl programs."
;  t)
(setq cperl-indent-level 4)
(setq cperl-continued-statement-offset 4)

;;
;; twittering-mode
;;
;(add-to-list 'load-path "~/lib/emacs/twittering-mode-2.0.0")
;(require 'twittering-mode)

;;
;; programming
;;
(setq show-trailing-whitespace t)
(add-hook 'before-save-hook
          (lambda ()
            (delete-trailing-whitespace)))

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
;;  cperl-mode
;;
(add-to-list 'load-path "~/lib/emacs/yaml-mode")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\.yml$'" . yaml-mode))

;;
;;  Rust
;;
(add-to-list 'load-path "~/lib/emacs/rust-mode")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(add-to-list 'load-path "~/lib/emacs/use-package")
;(add-to-list 'load-path "~/lib/emacs/diminish")
(eval-when-compile (require 'use-package))
;(require 'diminish)    ;; if you use :diminish
(require 'bind-key)    ;; if you use any :bind variant
(setq use-package-verbose t)
(setq use-package-minimum-reported-time 0.001)

(use-package scala-mode
	     :interpreter
	     ("scala" . scala-mode))

;; eof
