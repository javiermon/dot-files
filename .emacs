;; disable toolbar, menubar, scrollbar
;; (if (functionp 'tool-bar-mode) (tool-bar-mode -1))
;; (if (functionp 'menu-bar-mode) (menu-bar-mode -1))
;; (if (functionp 'scroll-bar-mode) (scroll-bar-mode -1))

;; start directory
(setq emacs-start-directory default-directory)

;; no welcome msg
(setq inhibit-startup-message t)

;; custom .el files:
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; I hate tabs!
(setq-default indent-tabs-mode nil)

;; theme
(when (display-graphic-p)
  (load-theme 'tango-dark t))

;; show column number
(column-number-mode 1)

;; turn on paren match highlighting
(show-paren-mode 1)
;; highlight entire bracket expression
;; (setq show-paren-style 'expression)

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

;; switch horizontal window split to vertical and viceversa
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(define-key ctl-x-4-map "s" 'toggle-window-split)

;; buffer move
(require 'buffer-move)

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

;; load TAGS file from current directory
(setq tags-file-name (concat emacs-start-directory "TAGS"))

;; recreate TAGS && cscope
(defun tag-and-cscope ()
  "ctags & cscope on startup directory"
  (interactive)
  (setq tag-cscope-command (format "(cd %s && ctags -Re && cscope-indexer -r 2>&1 > /dev/null &)" emacs-start-directory))
  (shell-command tag-cscope-command nil nil) )

(define-key ctl-x-4-map "t" 'tag-and-scope)

;; find file in tags:
(require 'find-file-in-tags)

;; find file in repository:
(require 'find-file-in-repository)
