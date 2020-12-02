(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes '(wombat))
 '(package-selected-packages
   '(which-key flycheck lsp-ui company-box poly-R poly-markdown polymode magit use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; update the package metadata is the local cache is missing
(unless package-archive-contents
  (package-refresh-contents))

;; disable startup screen
(setq inhibit-startup-screen t)

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; smart tab behavior - indent or complete
(setq tab-always-indent 'complete)

;; lsp prefix
(setq lsp-keymap-prefix "C-c l")

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

(use-package which-key
  :ensure t)

(use-package magit
  :ensure t)

(use-package diminish
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook	 ((ess-r-mode . lsp)
	  (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui
  :ensure t)

(use-package flycheck
  :ensure t)

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 2)
  (global-company-mode t))

;;(use-package company-box
;;  :ensure t
;;  :hook (company-mode . company-box-mode))

(use-package ess
  :ensure t
  :defer t ;; speeds up load time
  :init (require 'ess-site)
  :bind (
	 :map ess-mode-map
	 (";" . ess-insert-assign)
	 :map inferior-ess-mode-map
	 (";" . ess-insert-assign))
  )

;;(use-package polymode
;;  :ensure t
;;  )

;;(use-package poly-markdown
;;  :requires polymode
;;  :ensure t
;;  :mode (("\\.rmd" . poly-markdown+rmode)
;;	 ("\\.Rmd" . poly-markdown+rmode)
;;	 ("\\.md" . poly-markdown-mode)
;;	 )
;;  )

(use-package poly-R
  :requires polymode
  :ensure t
)

