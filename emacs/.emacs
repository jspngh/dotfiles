; packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; Package helpers
(defun ensure-and-require (package-name)
  (unless (package-installed-p package-name)
    (package-install package-name))
  (require package-name))

(ensure-and-require 'color-theme-sanityinc-tomorrow)

; theme settings
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;(load-theme 'monokai t)
(load-theme 'darktooth t)
;(load-theme 'gruvbox t)

; font settings
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Mono" :foundry "ADBO" :slant normal :weight normal :height 120 :width normal)))))
(global-linum-mode t)

; window settings
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(when window-system (set-frame-size (selected-frame) 224 58))

; scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

; no tabs
(setq-default indent-tabs-mode nil)

; evil mode
(require 'evil)
  (evil-mode 1)
(define-key evil-normal-state-map (kbd "M-.") #'racer-find-definition)
(define-key evil-normal-state-map (kbd "M-,") #'pop-tag-mark)

; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

; magit
(global-set-key (kbd "C-x g") 'magit-status)

; rust
(ensure-and-require 'rust-mode)
(add-hook 'rust-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))
(ensure-and-require 'cargo)
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(ensure-and-require 'racer)
(ensure-and-require 'company)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(ensure-and-require 'flycheck-rust)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(add-hook 'rust-mode-hook 'flycheck-mode)

(global-set-key (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)
(setq company-selection-wrap-around t)
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB") 'company-select-next)
     (define-key company-active-map [tab] 'company-select-next)))

; haskell
(ensure-and-require 'haskell-mode)
(add-hook 'haskell-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                 (append '((company-capf company-dabbrev-code))
                         company-backends))))

; elm
(ensure-and-require 'elm-mode)
;(add-hook 'elm-mode-hook #'elm-oracle-setup-completion)
(add-to-list 'company-backends 'company-elm)

; lua
(setq lua-indent-level 2)
(ensure-and-require 'lua-mode)
(ensure-and-require 'company-lua)
(add-to-list 'company-backends 'company-lua)

; multi-web
(ensure-and-require 'js2-mode)
(ensure-and-require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                  (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)
