;;; initialize extensions
;; author: Kevin.Jiang
;; E-mail: kittymiky@gmail.com


;; 设置扩展路径
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; php-mode
(require 'php-mode)

;; markdown-mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; auto-complete
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)

;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; golang
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(require 'go-autocomplete)

;; git
(require 'magit-gerrit)
(setq-default magit-gerrit-ssh-creds "git@10.123.4.215")
;(setq-default magit-gerrit-remote "gerrit")  
