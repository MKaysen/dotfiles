;; Set PATH and exec-path on unix like systems

(use-package exec-path-from-shell
  :ensure t)

(exec-path-from-shell-initialize)

(provide 'os-default-unix)
