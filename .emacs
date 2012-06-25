;; author: Kevin.Jiang
;; E-mail: kittymiky@gmail.com

;; 设置我的个人信息
(setq user-full-name "Kevin Jiang")
(setq user-mail-address "kittymiky@gmail.com")

;;----------------------------------------
;;             加载扩展文件
;;----------------------------------------
;; 设置扩展路径
(add-to-list 'load-path "~/.emacs.d/")

;; 关闭启动画面
(setq inhibit-startup-message t)

;; 在标题栏提示你目前在什么位置
;(setq frame-title-format "kevin@%b")
;; display buffer name or absolute file path name in the frame title
(defun frame-title-string ()
  "Return the file name of current buffer, using ~ if under home directory"
  (let
      ((fname (or
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

;; 显示时间，格式如下
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(transient-mark-mode t)

;; 语法高亮
(global-font-lock-mode t)

;; 以 y/n 代表 yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; color theme
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(require 'my-color-theme)
(color-theme-initialize)
(my-color-theme)

;; 支持emacs和外部程序的粘贴
(setq x-select-enable-clipboard t)

;; 启动窗口大小
(setq default-frame-alist
  '((height . 30) (width . 100) (menu-bar-lines . 20) (tool-bar-line . 0)))

;; 去掉工具栏
(tool-bar-mode 0)

;;  窗口切换
;(windmove-default-keybindings 'alt)
(windmove-default-keybindings)

;; 显示括号匹配,但不跳转到另外一个括号的位置
(show-paren-mode t)
(setq show-paren-style 'parentheses)
;; 开启括号自动补全
(electric-pair-mode t)


;; 不产生备份文件
(setq make-backup-files nil)

;; 防止页面滚动时跳动，scroll-margin 3可以在靠近屏幕边缘3行时就开始滚动
(setq scroll-margin 3
      scroll-conservatively 10000)

;; 把缺省的 major mode 设置为 text-mode, 而不是几乎什么功能也 没有的 fundamental-mode.
(setq default-major-mode 'text-mode)

;; 显示行列号
(require 'linum)
(global-linum-mode t)

;; 高亮当前行
(require 'hl-line)
(global-hl-line-mode t)

;; 高亮光标处的单词
(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-prev)

;; 当emacs退出时保存文件打开状态
(add-hook 'kill-emacs-hook
  '(lambda()(desktop-save "~/")))

;; 当emacs退出时保存打开的文件
(load "desktop") 
(desktop-save-mode 1)
(setq-default desktop-load-locked-desktop t)
(desktop-read)
(desktop-load-default)


;; replace tab with space
(setq-default indent-tabs-mode nil)
;; 设置tab为4个空格
(setq default-tab-width 4)
(setq tab-width 4)

(setq default-directory "~/")

;; auto complete
(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete-1.3.1//ac-dict")
(ac-config-default)

;; python
(require 'python-mode)

;; php mode
(load "php-mode")
(add-hook 'php-mode-hook
          '(lambda()
             (setq tab-width 4)
             (setq c-basic-offset 4)
             (setq indent-tabs-mode nil)))
;(define-key php-mode-map (kbd ";") 'self-insert-command)
;(define-key php-mode-map (kbd ")") 'self-insert-command)
;(define-key php-mode-map (kbd "(") 'self-insert-command)
;(define-key php-mode-map (kbd ",") 'self-insert-command)


;; tabbar mode
;(require 'tabbar)
;(tabbar-mode t)
;(global-set-key [(control shift tab)] 'tabbar-backward)
;(global-set-key [(control tab)] 'tabbar-forward)
;(put 'upcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)


;; use vim mode
(add-to-list 'load-path "~/.emacs.d/vim-mode/")
(require 'vim)
;(vim-mode 1)


;; 让 Emacs 可以直接打开和显示图片
(auto-image-file-mode)

