(setq max-lisp-eval-depth 20000)

;; remove static file line
(defun get-dynamic-request nil
  ""
  (interactive)
  (if (<= (point) (point-max))
      (if (search-forward-regexp "\\(.css\\|.gif\\|.jpg\\|.png\\|.js\\|blank.html\\|.ico\\)" nil t)
          (progn
            (move-beginning-of-line nil)
            (kill-line)
            (kill-line)
            (get-dynamic-request)))
    (message "end of buffer")))

;; use cygwin shell
(defun cygwin-shell ()
    (interactive)
    (let ((explicit-shell-file-name "c:/cygwin/bin/bash"))
     (call-interactively 'shell)))

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
    (kill-ring-save (mark) (point))))
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
