(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("01ce486c3a7c8b37cf13f8c95ca4bb3c11413228b35676025fdf239e77019ea1" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(package-selected-packages
   (quote
    (fill-column-indicator reykjavik-theme ## powerline-evil smart-mode-line-powerline-theme smart-mode-line powerline evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq inhibit-startup-screen t)


(load-theme 'reykjavik)

; (require 'smart-mode-line)
; (sml/setup)

(setq-default mode-line-format
 '(
   (:eval (propertize "%3c" 'face
                      (if (>= (current-column) 75)
                          'mode-line-80col-face
                        'mode-line-position-face)))

   ; read-only or modified status
   (:eval
    (cond (buffer-read-only
           (propertize "!RO" 'face 'mode-line-read-only-face))
          ((buffer-modified-p)
           (propertize "!**" 'face 'mode-line-modified-face))
          (t(propertize " λ " 'face 'mode-line-folder-face))))
   ; emacsclient [default -- keep?]
   ;; mode-line-client
   ; directory and buffer/file name
   " "
   (:propertize (:eval (shorten-directory default-directory 10))
                face mode-line-folder-face)
   (:propertize "%b"
                face mode-line-filename-face)
   "  ("
   (:propertize mode-name
                face mode-line-mode-face)
   ") "
   ; mode indicators: vc, recursive edit, major mode, minor modes, process, global
   (:propertize (vc-mode vc-mode)
                face mode-line-minor-mode-face)

   (:eval (propertize (format-mode-line minor-mode-alist)
                      'face 'mode-line-minor-mode-face))
   (:propertize mode-line-process
                face mode-line-process-face)
   (global-mode-string global-mode-string)
   ; nyan-mode uses nyan cat as an alternative to %p
   ;; (:eval (when nyan-mode (list (nyan-create))))
   ))



;; Helper function
(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
    output))

(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-position-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(make-face 'mode-line-80col-face)
(set-face-attribute 'mode-line nil
		    :foreground "gray60"
		    :background "gray20"
		    :inverse-video nil
		    :box '(:line-width 1 :color "gray20" :style nil))

(require 'evil)
(evil-mode 1)

(tool-bar-mode -1)
(scroll-bar-mode -1)

(defun smart-home ()
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
	 (beginning-of-line))))
(global-set-key (kbd "<s-left>") 'smart-home)
(global-set-key (kbd "<s-right>") 'move-end-of-line)

(when (window-system)
      (set-frame-width (selected-frame) 180)
      (set-frame-height (selected-frame) 60))

(global-linum-mode t)

(save-place-mode t)

(require 'fill-column-indicator)
(setq fci-rule-width 2)
(setq fci-rule-color "gray20")
(define-globalized-minor-mode global-fci-mode fci-mode
  (lambda () (fci-mode 1)))
(global-fci-mode 1)

(define-key evil-normal-state-map (kbd ";") 'evil-ex)
(define-key evil-normal-state-map (kbd ":") 'evil-repeat-find-char)
