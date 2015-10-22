;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;; No splash screen
(setq inhibit-startup-message t)

;; start directory
(setq emacs-start-directory default-directory)

;; custom .el files:
(add-to-list 'load-path "~/.emacs.d/lisp/")
;; custom themes:
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; custom tango-dark theme:
(load-theme 'tango-darker t)          ; dark theme

;; only run if Emacs is run in an X window
(when (display-graphic-p)
  (put 'scroll-left 'disabled nil)    ; right scroll bar
)

;; MELPA Stable
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;;(add-to-list 'package-archives
;;             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;; auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

;; anything
(require 'anything)
;;(require 'anything-match-plugin)
;;(require 'anything-config)

;; I hate tabs!
(setq-default indent-tabs-mode nil)

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

;; fill-column-indicator
(require 'fill-column-indicator)
(setq-default fci-rule-column 80)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
;; (global-fci-mode 1)

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
;; (semantic-mode 1)

;; c/c++ switch between myfile.cc and myfile.h with C-c o
(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key  (kbd "C-c o") 'ff-find-other-file)
    ;; hide/show mode for code folding
    (hide-ifdef-mode 1)
    (hs-minor-mode 1)))

;; load TAGS file from current directory
(setq tags-file-name (concat emacs-start-directory "TAGS"))

;; recreate TAGS && cscope
(defun tag-and-cscope ()
  "ctags & cscope on startup directory"
  (interactive)
  (setq tag-cscope-command (format "cd %s && ctags -Re && cscope-indexer -r" emacs-start-directory))
  (save-window-excursion
    (async-shell-command tag-cscope-command)))

(define-key ctl-x-4-map "t" 'tag-and-scope)

;; reload tags without asking
(setq tags-revert-without-query t)

;; find file in tags:
(require 'find-file-in-tags)

;; find file in repository:
(require 'find-file-in-repository)

;; Git
(require 'git)
(require 'git-blame)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("ffd516378d0a74228c704fd53308aa953398ba9b988d9895f8a1b7f7a1121070" "c22c6c8806e9ea14eb0f72e225ccd6ba93263bfee6234cbed551ce477ef572d0" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
