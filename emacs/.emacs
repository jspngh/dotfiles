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
(ensure-and-require 'rust-mode)

; theme settings
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(custom-set-variables
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" \
     "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" \
     "cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" \
     "f34b107e8c8443fe22f189816c134a2cc3b1452c8874d2a4b2e7bb5fe681a10b" \
     default))))

; font settings
(custom-set-faces
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight normal :height 120 :width normal)))))
(global-linum-mode t)

; window settings
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(when window-system (set-frame-size (selected-frame) 160 50))

; scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

; evil mode
(require 'evil)
  (evil-mode 1)
(define-key evil-normal-state-map (kbd "M-.") #'racer-find-definition)
(define-key evil-normal-state-map (kbd "M-,") #'pop-tag-mark)

; magit
(global-set-key (kbd "C-x g") 'magit-status)

;; Rust settings
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

; elm
(ensure-and-require 'elm-mode)
(add-hook 'elm-mode-hook #'elm-oracle-setup-completion)
(add-to-list 'company-backends 'company-elm)
