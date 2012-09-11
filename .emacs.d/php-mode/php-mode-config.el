(require 'php-mode)
(add-hook 'php-mode-hook
          '(lambda()
             (setq tab-width 4)
             (setq c-basic-offset 4)
             (setq indent-tabs-mode nil)))
(add-hook 'php-mode-hook 'hs-minor-mode)