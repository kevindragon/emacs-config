;;; initialize extensions
;; author: Kevin.Jiang
;; E-mail: kittymiky@gmail.com



;; keep cursor at same position when scrolling
(setq scroll-preserve-screen-position 1)
;; scroll window up/down by one line
(global-set-key (kbd "M-n") (kbd "C-u 1 C-v"))
(global-set-key (kbd "M-p") (kbd "C-u 1 M-v"))


;; 设置扩展路径
(add-to-list 'load-path "~/.emacs.d/lisp/")

(setq max-lisp-eval-depth 20000)

(prefer-coding-system 'utf-8)

;; uniq-line
(defun uniq-lines (beg end)
  "Unique lines in region.
Called from a program, there are two arguments:
BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (not (eobp))
        (kill-line 1)
        (yank)
        (let ((next-line (point)))
          (while
              (re-search-forward
               (format "^%s" (regexp-quote (car kill-ring))) nil t)
            (replace-match "" nil nil))
          (goto-char next-line))))))

;; next window and previous window
(global-set-key "\C-x\C-n" 'other-window)
(defun other-window-backward (&optional n)
  "Select Nth previous window"
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))
(global-set-key "\C-x\C-p" 'other-window-backward)

;; 换行缩进
(defun newline-and-indent-ex ()
  "Goto end current line then newline and indent"
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))
(global-set-key "\C-o" 'newline-and-indent-ex)

;; 复制一行或者多行
(defun copy-lines (&optional arg)
  (interactive "p")
  (save-excursion
    (beginning-of-line)
    (set-mark (point))
    (next-line arg)
    (beginning-of-line)
    (kill-ring-save (mark) (point))
    (set-mark (point))))
(global-set-key "\C-cl" 'copy-lines)

;; 打开光标所在行的文件
(defun open-current-line-file ()
  "open the file which in the current line"
  (interactive)
  (save-excursion
    (beginning-of-line)
    (set-mark (point))
    (end-of-line)
    (kill-ring-save (mark) (point)))
  (setq new-buffer-name (car kill-ring))
  (if (file-exists-p new-buffer-name)
      (find-file new-buffer-name)
    (message "file \"%s\" does not exists" new-buffer-name)))
(global-set-key "\C-cw" 'open-current-line-file)


;; 设置自动折行，习惯了vim下面的set wrap
(defun set-wrap ()
  "自动折行开关"
  (interactive)
  (save-excursion
    (toggle-truncate-lines)))

;; special config by different OS
(cond
 ((string-equal system-type "darwin")
  (load "darwin")))

;; melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

; list the packages you want
;(setq package-list 
;  '(auto-complete yasnippet go-mode go-autocomplete highlight-symbol
;    web-mode js2-mode flymake flycheck color-theme angular-snippets
;    dired+ quickrun undo-tree exec-path-from-shell))
; list the packages you want
(setq package-list 
  '(exec-path-from-shell dired+ auto-complete yasnippet browse-kill-ring+ sr-speedbar
    highlight-symbol flymake flycheck color-theme quickrun undo-tree clojure-mode
    markdown-mode web-mode js2-mode angular-snippets go-mode go-autocomplete
    php-mode sass-mode auto-highlight-symbol magit company slime cider rust-mode))
; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))
  ; install the missing package-list
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; Auto-complete
;(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; auto highlight symbol
(global-auto-highlight-symbol-mode t)

;; web mode
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
; set indentation
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 4)

;; js2 mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(setq-default js2-basic-offset 2)

;; Golang
(require 'go-autocomplete)
(require 'auto-complete-config)
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook
          (lambda ()
            (progn
              (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
              (local-set-key (kbd "C-c i") 'go-goto-imports)
              (local-set-key (kbd "M-.") 'godef-jump))))
;(require 'go-flymake)

;; php mode
(require 'php-mode)
;(add-hook 'php-mode-hook 'hs-minor-mode)

;; load color theme
(load "my-color-theme")

;; rust racer
(when (and (package-installed-p 'rust-mode) 
           (package-installed-p 'company))
  (setq racer-rust-src-path "C:/Program Files/Rust stable 1.1/source/src/")
  (setq racer-cmd "C:/Program Files/racer/target/release/racer.exe")
  (add-to-list 'load-path "C:/Program Files/racer/editors/emacs")
  (eval-after-load "rust-mode" '(require 'racer))
  (require 'racer)
  (add-hook 'rust-mode-hook #'racer-activate)
  (require 'rust-mode)
  (define-key rust-mode-map (kbd "TAB") #'racer-complete-or-indent)
  (define-key rust-mode-map (kbd "M-.") #'racer-find-definition))

;; Enable company mode
(add-hook 'after-init-hook 'global-company-mode)
