;;;; MKaysen's Emacs init.el file
;  Author: Mikkel Kaysen
;  Created: 12 April 2017
;  Last Edit: 12 April 2017


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path (expand-file-name "init" user-emacs-directory))

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(require 'init-elpa)
(require 'init-evil)
(require 'init-theme)
(require 'init-os)
(require 'init-dev)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
