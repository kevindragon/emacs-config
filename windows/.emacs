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

;; 关闭出错时的提示声音
;(setq visible-bell t)

;; 语法高亮
(global-font-lock-mode t)

;; 以 y/n 代表 yes/no
(fset 'yes-or-no-p 'y-or-n-p)

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
(setq scroll-conservatively 10000
      scroll-margin 3)

;; 把缺省的 major mode 设置为 text-mode, 而不是几乎什么功能也没有的 fundamental-mode.
(setq default-major-mode 'text-mode)

;; 设置默认编码，指定新建buffer的默认编码为utf-8-unix，换行符为unix的方式
;(setq default-buffer-file-coding-system 'utf-8-unix)

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

;; 记住上次文件打开的位置
(require 'saveplace)
(setq-default save-place t)

;; replace tab with space
(setq-default indent-tabs-mode nil)
;; 设置tab为4个空格
(setq default-tab-width 4)
(setq tab-width 4)

;; default directory
(setq default-directory "~/")

;; 递归minibuffer
(setq enable-recursive-minibuffers t)

;; 加载自定义函数以及自定义快捷键
(load "myfuns")

;; auto complete
(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1/")
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete-1.3.1/ac-dict")
(global-auto-complete-mode t)
;(ac-config-default)
;(setq ac-auto-start 2)
;(setq ac-dwim t)

;; yasnippet
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
(setq yas/snippet-dirs '("~/.emacs.d/yasnippet/snippets" "~/.emacs.d/yasnippet/extras/imported"))
(setq yas/prompt-functions 
      '(yas/dropdown-prompt yas/x-prompt yas/completing-prompt yas/ido-prompt yas/no-prompt))
(yas/global-mode 1)
(yas/minor-mode-on)
;; 如果是emacs-list-mode就把yas关掉
(if (eq major-mode 'emacs-lisp-mode)
    (yas/global-mode 0))

;; 在行首删除一行时，把换行符也删除掉
;(setq-default kill-whole-line t)
(setq-default kill-ring-max 10000)

;; color theme
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(require 'my-color-theme)
(color-theme-initialize)
(my-color-theme)

;;; 加载cedet，在24版本中已经自带cedet
(require 'cedet)
(global-ede-mode 1)

;; python
(require 'python-mode)
(require 'pycomplete)
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)
(setq interpreter-mode-alist(cons '("python" . python-mode)
                                  interpreter-mode-alist))
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

;; php mode
(add-to-list 'load-path "~/.emacs.d/php-mode/")
(load "php-mode-config")

;; go lang mode
(require 'go-mode-load)

;; tabbar mode
;(require 'tabbar)
;;设置tabbar不分组显示
;(setq tabbar-buffer-groups-function nil)
;(tabbar-mode t)
;(global-set-key [(control shift tab)] 'tabbar-backward)
;(global-set-key [(control tab)] 'tabbar-forward)

;; use vim mode
;(add-to-list 'load-path "~/.emacs.d/vim-mode/")
;(require 'vim)
;(vim-mode 1)

;; 让Emacs可以直接打开和显示图片(貌似不管用)
(auto-image-file-mode)

;; web mode
(add-to-list 'auto-mode-alist 
             (cons "\\.tpl" 'html-mode))

(put 'dired-find-alternate-file 'disabled nil)

;; 设置文件名为gbk
(if (eq system-type 'windows-nt)
    (setq file-name-coding-system 'gbk))
;;指定当前buffer的写入编码，只对当前buffer有效，即此命令写在配置文件中无效，只能通过M-x来执行
(set-buffer-file-coding-system 'utf-8-unix)
;;指定新建buffer的默认编码为utf-8-unix，换行符为unix的方式
(setq default-buffer-file-coding-system 'utf-8-unix)
;;将utf-8放到编码顺序表的最开始，即先从utf-8开始识别编码，此命令可以多次使用，后指定的编码先探测
(prefer-coding-system 'gb18030)
(prefer-coding-system 'utf-8)
(prefer-coding-system 'chinese-gbk)
;;指定Emacs的语言环境，按照特定语言环境设置前面的两个变量
(set-language-environment 'utf-8)

(put 'upcase-region 'disabled nil)

;; 当emacs退出时保存文件打开状态
(add-hook 'kill-emacs-hook
  '(lambda()(desktop-save "~/")))

;; 当emacs退出时保存打开的文件
(load "desktop") 
(desktop-save-mode 1)
(setq-default desktop-load-locked-desktop t)
(desktop-read)
(desktop-load-default)
