;; author: Kevin.Jiang
;; E-mail: kittymiky@gmail.com

;; 设置我的个人信息
(setq user-full-name "Kevin Jiang")
(setq user-mail-address "kittymiky@gmail.com")


;; 设置扩展路径
(add-to-list 'load-path "~/.emacs.d/")


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

;; default directory
(setq default-directory "~/")

;; 把kill-ring设置大一些
(setq-default kill-ring-max 100000)


;; if system type is linux load ibus mode
(when (eq system-type 'gnu/linux)
      (add-to-list 'load-path "~/.emacs.d/ibus/")
      (require 'ibus)
      (add-hook 'after-init-hook 'ibus-mode-on))


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
(define-key php-mode-map '[M-S-down] 'flymake-goto-next-error)


;;把speedbar嵌入到emacs的窗口中，而不是新建一个窗口启动，同时绑定到F5上。  
(require 'sr-speedbar)  
(setq sr-speedbar-right-side nil)  
(setq sr-speedbar-width 30)  
(setq speedbar-show-unknown-files t)  
(global-set-key (kbd "<f5>") (lambda()  
          (interactive)  
          (sr-speedbar-toggle)))  
