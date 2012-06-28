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

(require 'cc-mode)
(require 'cc-langs)

;; 定义组
(defgroup php nil
  "Silly walks in the PHP language."
  :group 'languages
  :version "0.1"
  :link '(emacs-commentary-link "php"))

(defcustom shit "shit"
  "shit var"
  :type 'string
  :group 'php)

;; 定义主模式
(define-derived-mode php-mode prog-mode "PHP"
  "Major mode for PHP. \\{php-mode-map}"
  (setq myvar nil))

(provide 'php-mode)

;;; php-mode.el ends here
