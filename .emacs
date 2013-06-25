;; disable toolbar, menubar, scrollbar
;; (if (functionp 'tool-bar-mode) (tool-bar-mode -1))
;; (if (functionp 'menu-bar-mode) (menu-bar-mode -1))
;; (if (functionp 'scroll-bar-mode) (scroll-bar-mode -1))

;; no welcome msg
(setq inhibit-startup-message t)

;; custom .el files:
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; I hate tabs!
(setq-default indent-tabs-mode nil)

;; show column number
(column-number-mode 1)

;; remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; utf-8
(require 'un-define "un-define" t)
(set-buffer-file-coding-system 'utf-8 'utf-8-unix)
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-default default-buffer-file-coding-system 'utf-8-unix)
;; mark selection
(setq transient-mark-mode t)

;; smart-tab
;; (require 'smart-tab)
;; (global-smart-tab-mode 1)

;; python pylint, flymake:
(require 'flymake-pylint)
;; Underline errors instead of highlight
;;(custom-set-faces
;; '(flymake-errline ((((class color)) (:underline "red"))))
;; '(flymake-warnline ((((class color)) (:underline "yellow")))))

;; c sane identation
(setq c-default-style "linux" c-basic-offset 4)

;; cscope
(require 'xcscope)
;; (setq cscope-do-not-update-database t)

;; close cscope buffer after pop-mark
(defun cscope-pop-mark-and-close ()
  "close the *cscope* buffer when we pop the mark"
  (interactive)
  (kill-buffer "*cscope*")
  (cscope-pop-mark))

;; semantic mode
(semantic-mode 1)

;; c/c++ switch between myfile.cc and myfile.h with C-c o
(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

;; find file in tags:
(require 'find-file-in-tags)

;; find file in repository:
(require 'find-file-in-repository)
