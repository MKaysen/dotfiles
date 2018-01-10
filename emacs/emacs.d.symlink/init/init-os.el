(add-to-list 'load-path (expand-file-name "os" user-emacs-directory))

(pcase system-type
      ('gnu/linux
       ;;Linux specific stuff
       (require 'os-default-unix)
       )
      ('darwin
       ;;MacOS stuff
       (require 'os-default-unix)
       (require 'os-darwin)))

(provide 'init-os)
