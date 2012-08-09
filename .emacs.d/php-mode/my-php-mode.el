;;; php-mode.el --- major mode for editing PHP code

;; Copyright (C) 2012 Kevin Jiang

;; Maintainer: Kevin Jiang <kittymiky@gmail.com>
;; Original Author: Kevin Jiang 2012
;; Keywords: php languages oop
;; Created: 2012-06-28
;; X-URL:   

(defconst php-mode-version "0.1"
  "PHP Mode version number.")

(defconst php-mode-modified "2012-06-28"
  "PHP Mode build date.")

;;; License

;; GPL

;;; Usage

;; Put this file in your Emacs lisp path (eg. site-lisp) and add to
;; your .emacs file:
;;
;;   (require 'php-mode)

;; To use abbrev-mode, add lines like this:
;;   (add-hook 'php-mode-hook
;;     '(lambda () (define-abbrev php-mode-abbrev-table "ex" "extends")))

;;; Code:


;;;###autoload
(add-to-list 'auto-mode-alist 
             (cons "\\.php[s345]?\\|\\.phtml\\|\\.inc" 
                   'php-mode))

;; 定义组
(defgroup php nil
  "Silly walks in the PHP language."
  :group 'languages
  :version "0.1"
  :link '(emacs-commentary-link "php"))

;; 定义一个hook供调用
(defcustom php-mode-hook nil
  "List of functions to be executed on entry to `php-mode."
  :type 'hook
  :group 'php)

;; 设置高亮的函数
(defun set-php-mode-highlight ()
  "设置php-mode高亮"
  (font-lock-add-keywords
   'php-mode
   (("\\<\\(global\\|global\\|try\\|catch\\)\\>" . font-lock-keyword-face))
   ))

;; 定义主模式
(define-derived-mode php-mode
  c-mode "PHP"
  "Major mode for PHP. \\{php-mode-map}"
  (set-php-mode-highlight)
  (run-hook 'php-mode-hook))

(provide 'php-mode)

;;; php-mode.el ends here
