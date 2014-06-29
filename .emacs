;; author: Kevin.Jiang
;; E-mail: kittymiky@gmail.com

;; 设置我的个人信息
(setq user-full-name "Kevin Jiang")
(setq user-mail-address "kittymiky@gmail.com")


;; 设置扩展路径
(add-to-list 'load-path "~/.emacs.d/")

;; load color theme
(load "my-color-theme")

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

;; 启动窗口大小
(if (eq system-type 'windows-nt)
  (setq default-frame-alist
    '((height . 30) (width . 100) (menu-bar-lines . 20) (tool-bar-line . 0)))
  (setq default-frame-alist
    '((height . 30) (width . 100))))

;; 防止页面滚动时跳动，scroll-margin 3可以在靠近屏幕边缘3行时就开始滚动
(setq scroll-conservatively 10000
      scroll-margin 3)

;; 去掉工具栏
(tool-bar-mode 0)

;; 显示时间，格式如下
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(transient-mark-mode t)
; display line number in the mode line
(line-number-mode)
; display column number in the mode line
(column-number-mode)

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

;; default directory
(setq default-directory "~/")

;; 把kill-ring设置大一些
(setq-default kill-ring-max 100000)


;; if system type is linux load ibus mode
(when (eq system-type 'gnu/linux)
      (add-to-list 'load-path "~/.emacs.d/ibus/")
      (require 'ibus)
      (add-hook 'after-init-hook 'ibus-mode-on)
      ;;(set-default-font "-unknown-Droid Sans Mono-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1"))
      (set-default-font "-unknown-Ubuntu Mono-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1"))

(when (string= system-type 'windows-nt)
  ;; 设置文件名为gbk
  (setq file-name-coding-system 'gbk)
  ;;指定当前buffer的写入编码，只对当前buffer有效，即此命令写在配置文件中无效，只能通过M-x来执行
  ;(set-buffer-file-coding-system 'utf-8-unix)
  ;;指定新建buffer的默认编码为utf-8-unix，换行符为unix的方式
  (setq default-buffer-file-coding-system 'utf-8-unix)
  ;;将utf-8放到编码顺序表的最开始，即先从utf-8开始识别编码，此命令可以多次使用，后指定的编码先探测
  (prefer-coding-system 'gb18030)
  (prefer-coding-system 'utf-8)
  (prefer-coding-system 'chinese-gbk)
  ;;指定Emacs的语言环境，按照特定语言环境设置前面的两个变量
  (set-language-environment 'utf-8))

(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

;; yasnippet
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
(setq yas/snippet-dirs '("~/.emacs.d/yasnippet/snippets" "~/.emacs.d/yasnippet/extras/imported"))
(setq yas/prompt-functions 
      '(yas/dropdown-prompt yas/x-prompt yas/completing-prompt yas/ido-prompt yas/no-prompt))
(setq yas-indent-line 'fixed)
(yas/global-mode 1)
(yas/minor-mode-on)

;; popup was exclued from new auto complete, add popup first
(add-to-list 'load-path "~/.emacs.d/popup-el/")
(add-to-list 'load-path "~/.emacs.d/auto-complete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/dict")
;(global-auto-complete-mode t)
(setq ac-auto-start 1)
(ac-config-default)
;(local-set-key (kbd "M-/") 'semantic-complete-analyze-inline)
;(local-set-key "." 'semantic-complete-self-insert)
;(local-set-key ">" 'semantic-complete-self-insert)
    


;; php mode
(add-to-list 'load-path "~/.emacs.d/php-mode/")
(require 'php-mode)
(add-hook 'php-mode-hook
          '(lambda()
             (setq tab-width 4)
             (setq c-basic-offset 4)
             (setq indent-tabs-mode nil)
             (require 'php-completion) 
             (php-completion-mode t) 
             (define-key php-mode-map (kbd "C-c p") 'phpcmp-complete) 
             (when (require 'auto-complete nil t) 
                   (make-variable-buffer-local 'ac-sources) 
                   (add-to-list 'ac-sources 'ac-source-php-completion) 
                   (auto-complete-mode t))))
(when (eq system-type 'gnu/linux)
  (add-to-list 'load-path "~/.emacs.d/emacs-flymake")
  (require 'flymake)

  (defun flymake-php-init ()
    "Use php to check the syntax of the current file."
    (let* ((temp (flymake-init-create-temp-buffer-copy
                  'flymake-create-temp-inplace))
           (local (file-relative-name temp
                                      (file-name-directory buffer-file-name))))
      (list "php" (list "-f" local "-l"))))

  (add-to-list 'flymake-err-line-patterns
               '("\\(Parse\\|Fatal\\) error: +\\(.*?\\)
      in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.php$" flymake-php-init))

  ;; Drupal-type extensions
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.module$" flymake-php-init))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.install$" flymake-php-init))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.inc$" flymake-php-init))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.engine$" flymake-php-init))

  (add-hook 'php-mode-hook (lambda () (flymake-mode 1)))
  (define-key php-mode-map '[M-S-up] 'flymake-goto-prev-error)
  (define-key php-mode-map '[M-S-down] 'flymake-goto-next-error))


;; web settings
(add-to-list 'auto-mode-alist 
             (cons "\\.tpl" 'html-mode))


;;把speedbar嵌入到emacs的窗口中，而不是新建一个窗口启动，同时绑定到F5上。
(require 'sr-speedbar)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-width 30)
(setq speedbar-show-unknown-files t)
(global-set-key (kbd "<f5>") 
                (lambda()
                  (interactive)
                  (sr-speedbar-toggle)))


;; load myself functions
(load "myfuns")


;; set tabs
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)


;; set version control
(setq vc-handled-backends nil)


;; Go lang
(load "go-config")


;; Markdown mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;; tabbar
(add-to-list 'load-path "~/.emacs.d/tabbar/")
(require 'tabbar)
(load "tabbar-tweak")
;(setq tabbar-ruler-global-tabbar t) ; If you want tabbar
;(setq tabbar-ruler-global-ruler t) ; if you want a global ruler
;(setq tabbar-ruler-popup-menu t) ; If you want a popup menu.
;(setq tabbar-ruler-popup-toolbar t) ; If you want a popup toolbar
;(setq tabbar-ruler-popup-scrollbar t) ; If you want to only show the
;                                      ; scroll bar when your mouse is moving.
;(require 'tabbar-ruler)
(setq tabbar-buffer-groups-function
      (lambda ()
        (list "All")))

