;; custom .el files:
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; utf-8
(require 'un-define "un-define" t)
(set-buffer-file-coding-system 'utf-8 'utf-8-unix)
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-default default-buffer-file-coding-system 'utf-8-unix)
;; mark selection
(setq transient-mark-mode t)

;; python pylint, flymake:
;;(require 'flymake)
;;(require 'flymake-cursor)
;;
;;(when (load "flymake" t)
;;      (defun flymake-pylint-init ()
;;        (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                           'flymake-create-temp-inplace))
;;           (local-file (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name))))
;;          (list "epylint" (list local-file))))
;;    
;;      (add-to-list 'flymake-allowed-file-name-masks
;;               '("\\.py\\'" flymake-pylint-init)))
;;
;;(add-hook 'python-mode-hook
;;          (lambda () (flymake-mode 1)))

(require 'flymake-pylint)
