;;; initialize extensions
;; author: Kevin.Jiang
;; E-mail: kittymiky@gmail.com


;; 设置扩展路径
(add-to-list 'load-path "~/.emacs.d/lisp/")

(when (string= system-type 'windows-nt)
  ;; 设置文件名为gbk
  (setq file-name-coding-system 'gbk)
  ;;指定新建buffer的默认编码为utf-8-unix，换行符为unix的方式
  (setq default-buffer-file-coding-system 'utf-8-unix)
  ;;将utf-8放到编码顺序表的最开始，即先从utf-8开始识别编码，此命令可以多次使用，后指定的编码先探测
  (prefer-coding-system 'gb18030)
  (prefer-coding-system 'utf-8)
  (prefer-coding-system 'chinese-gbk)
  ;;指定Emacs的语言环境，按照特定语言环境设置前面的两个变量
  (set-language-environment 'utf-8))

;; lambda of mine, haha ^_^
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

;; melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; eide
;(eide-start)
;(setq eide-custom-menu-window-height 'full)
;(setq eide-custom-menu-window-position 'left)

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
(add-hook 'before-save-hook #'gofmt-before-save)

;; speedbar
(setq speedbar-use-images nil)
(setq sr-speedbar-max-width 40)
(custom-set-variables '(speedbar-show-unknown-files t))nil
