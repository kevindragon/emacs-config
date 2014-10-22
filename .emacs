;; author: Kevin.Jiang
;; E-mail: kittymiky@gmail.com

;; 设置我的个人信息
(setq user-full-name "Kevin Jiang")
(setq user-mail-address "kittymiky@gmail.com")

;; 关闭启动画面
(setq inhibit-startup-message t)

;; 在标题栏提示你目前在什么位置
(defun frame-title-string ()
  "Return the file name of current buffer, using ~ if under home directory"
  (let ((fname (or
               (buffer-file-name (current-buffer))
               (buffer-name)))
       (max-len 100))
    (when (string-match (getenv "HOME") fname)
      (setq fname (replace-match "~" t t fname)))
    (if (> (length fname) max-len)
        (setq fname
              (concat "..."
                      (substring fname (- (length fname) max-len)))))
    fname))
(setq frame-title-format '("Kevin@"(:eval (frame-title-string))))

;; 去掉工具栏
(tool-bar-mode 0)

;; 启动窗口大小
(if (eq system-type 'windows-nt)
  (setq default-frame-alist
    '((height . 30) (width . 100) (menu-bar-lines . 20) (tool-bar-line . 0)))
  (setq default-frame-alist
    '((height . 30) (width . 100))))

;; 防止页面滚动时跳动，scroll-margin 3可以在靠近屏幕边缘3行时就开始滚动
(setq scroll-conservatively 10000
      scroll-margin 3)

;; 显示时间，格式如下
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(transient-mark-mode t)

;; 显示行号和列号
(line-number-mode)
(column-number-mode)

;; 显示行列号
(require 'linum)
(global-linum-mode t)

;; 高亮当前行
(require 'hl-line)
(global-hl-line-mode t)

;; 支持emacs和外部程序的粘贴
(setq x-select-enable-clipboard t)

;; 当emacs退出时保存打开的文件
(load "desktop") 
(desktop-save-mode 1)
(setq-default desktop-load-locked-desktop t)
(desktop-load-default)
(desktop-read)

;; 当emacs退出时保存文件打开状态
(add-hook 'kill-emacs-hook
  '(lambda()(desktop-save "~/.emacs.d")))

;; 记住上次文件打开的位置
(require 'saveplace)
(setq-default save-place t)

;; 以 y/n 代表 yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; 显示括号匹配,但不跳转到另外一个括号的位置
(show-paren-mode t)
;; 开启括号自动补全
(electric-pair-mode t)

;; 不产生备份文件
(setq make-backup-files nil)

;; 把kill-ring设置大一些
(setq-default kill-ring-max 100000)

;; tab size
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)

;; init
(load-file "~/.emacs.d/lisp/init.el")
