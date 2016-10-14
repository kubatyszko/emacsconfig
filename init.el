;(server-start)
(package-initialize)

(global-set-key [f10] '(lambda () (interactive) (switch-to-buffer "*scratch*")))
(global-set-key [f9] 'hl-line-mode)
(global-set-key [f8] 'crosshairs-mode)

(global-set-key (kbd "C-x C-b") 'ibuffer) 
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-c C-k") 'compile)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(global-set-key (kbd "C-x p") 'previous-multiframe-window)

(global-unset-key (kbd "C-w"))
(global-set-key (kbd "C-w") 'backward-kill-word)

(global-set-key (kbd "C-c w n") 'wconf-use-next)
(global-set-key (kbd "C-c w p") 'wconf-use-previous)
(global-set-key (kbd "C-c w s") 'wconf-store-all)
(global-set-key (kbd "C-c w l") 'wconf-restore-all)
(global-set-key (kbd "C-c w w") 'wconf-save)

;(global-unset-key (kbd "C-^"))
;(global-set-key (kbd "C-^") 'goto-match-paren)
(global-set-key (kbd "C-^") 'forward-or-backward-sexp)

(global-unset-key (kbd "ESC <up>"))

(global-set-key (kbd "ESC <down>") 'scroll-up-line)
(global-set-key (kbd "ESC <up>") 'scroll-down-line)

(global-set-key (kbd "<C-M-down>") 'scroll-other-window-up)
(global-set-key (kbd "<C-M-up>") 'scroll-other-window-down)

(global-set-key "\M-y" 'popup-kill-ring)
                                        ;(global-set-key (kbd "C-x g") 'google-this-mode-submap)

(hl-line-mode)

(defun scroll-other-window-down ()
  (interactive)
  (scroll-other-window -1)
  )

(defun scroll-other-window-up ()
  (interactive)
  (scroll-other-window 1)
  )


;(defun pbcopy ()
;  (interactive)
;  (call-process-region (point) (mark) "pbcopy")
;  (setq deactivate-mark t))
;
;(defun pbpaste ()
;  (interactive)
;  (call-process-region (point) (if mark-active (mark) (point)) "pbpaste" t t))
;
;(defun pbcut ()
;  (interactive)
;  (pbcopy)
;  (delete-region (region-beginning) (region-end)))
;
;(global-set-key (kbd "C-c c") 'pbcopy)
;(global-set-key (kbd "C-c v") 'pbpaste)
;(global-set-key (kbd "C-c x") 'pbcut)
;

(set-face-background hl-line-face "color-235")
(set-face-background col-highlight-face "color-235")

(setq toggle-crosshairs-when-idle 3)

(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert %.
vi style of % jumping to matching brace."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

(defun forward-or-backward-sexp (&optional arg)
  "Go to the matching parenthesis character if one is adjacent to point."
  (interactive "p")
  (cond ((looking-at "\\s(") (forward-sexp arg))
        ((looking-back "\\s)" 1) (backward-sexp arg))
        ;; Now, try to succeed from inside of a bracket
        ((looking-at "\\s)") (forward-char) (backward-sexp arg))
        ((looking-back "\\s(" 1) (backward-char) (forward-sexp arg))))


(autoload 'ruby-mode "ruby-mode" "Ruby Mode." t)

(require 'package)
(require 'tramp)

(setq tramp-default-method "scp")

(add-to-list 'tramp-connection-properties
             (list (regexp-quote "/ssh:mac:")
                   "remote-shell" "/bin/bash"))

(add-to-list 'tramp-connection-properties
             (list (regexp-quote "/ssh:mac:")
                   "remote-shell-login" "/bin/bash"))

(add-to-list 'tramp-default-method-alist '("mac" "" "scp"))
(add-to-list 'tramp-default-method-alist '("192.168.59.3" "" "scp"))
(add-to-list 'tramp-default-method-alist '("192.168.4.100" "" "ftp"))

(setq desktop-buffers-not-to-save "^$")


(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list
 'package-archives
 '("melpa" . "https://melpa.org/packages/")
 t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'auto-mode-alist '("\\.zsh$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
(add-to-list 'load-path "~/.emacs.d/packages/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")




(require 'shell-switcher)

  (autoload 'shell-toggle "shell-toggle"
   "Toggles between the shell buffer and whatever buffer you are editing."
   t)
  (autoload 'shell-toggle-cd "shell-toggle"
   "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)




(defvar kt/packages '(ac-slime
                          auto-complete
                          autopair
                          clojure-mode
                          coffee-mode
                          csharp-mode
                          deft
                          erlang
                          feature-mode
                          flycheck
                          gist
                          go-autocomplete
                          go-eldoc
                          go-mode
                          graphviz-dot-mode
                          haml-mode
                          haskell-mode
                          htmlize
                          idris-mode
                          magit
                          markdown-mode
                          marmalade
                          nodejs-repl
                          o-blog
                          org
                          paredit
                          php-mode
                          puppet-mode
                          restclient
b                          rvm
                          scala-mode
                          smex
                          shell-switcher
                          sml-mode
                          web-mode
                          writegood-mode
                          yaml-mode)
  "Default packages")



(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(delete-selection-mode t)
(transient-mark-mode t)

(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))



(defalias 'yes-or-no-p 'y-or-n-p)


(show-paren-mode t)

(smex-initialize)

(require 'autopair)

(require 'auto-complete-config)
(ac-config-default)


(add-hook 'ruby-mode-hook
          (lambda ()
            (autopair-mode)))


(add-hook 'haskell-mode-hook 'intero-mode)

(rvm-use-default)

(setenv "PATH"
  (concat
   (getenv "PATH")
   ":" "/usr/local/bin"
  )
)


;Magit

;btc-ticker-mode

;(add-to-list 'load-path "~/.emacs.d/vendor/bundler.el")
;(require 'bundler)

(require 'popup)
(require 'pos-tip)
(require 'popup-kill-ring)



(defun refresh-hackernews ()
    (message "refreshing hackernews")
    (with-selected-window (get-buffer-window (get-buffer "*hackernews*"))
      (hackernews)
      (shrink-window-if-larger-than-buffer)
      (enlarge-window 1)
      ))


(hackernews)
;(set-face-attribute 'default nil :family "Literation Mono Powerline")
;(set-face-attribute 'default nil :family "Droid Sans Mono Slashed Powerline")

(set-face-attribute 'default nil :font "Inconsolata for Powerline")
;(set-face-attribute 'default nil :family "Meslo LG S for Powerline")
;(set-frame-font "Meslo LG S for Powerline")
;(set-frame-font "Inconsolata-dz for Powerline")
;(set-face-attribute 'default nil :font "Roboto Mono Light for Powerline")
;(set-face-attribute 'default nil :family "Andale Mono")
;(set-face-attribute 'default nil :family "Monaco")


(set-face-attribute 'default nil :height 120)

(setq my-timer (run-with-idle-timer 240 1 'refresh-hackernews))
(setq tramp-default-method "ssh")
(setq temporary-file-directory "/tmp/")
(setq small-temporary-file-directory "/tmp/")
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq kill-whole-line t)
(setq show-paren-style 'expression)

(show-paren-mode t)

;(require 'spaceline-config)
;(spaceline-spacemacs-theme)

;(refresh-hackernews)

(require 'dired+)


(defvar persistent-scratch-filename
  "~/.emacs.d/emacs-persistent-scratch"
  "Location of *scratch contents*")

(defvar persistent-scratch-backup-directory
  "~/.emacs.d/emacs-persistent-scratch-backups/"
  "location of backups of the *scratch* buffer")

(defun make-persistent-scratch-backup-name ()
  "create a filename to backup the current scratch file by concatenating persistent-scratch-backup-directori with the current date and time"
  (concat
   persistent-scratch-backup-directory
   (replace-regexp-in-string
    (regexp-quote " ") "-" (current-time-string))))

(defun save-persistent-scratch ()
  (interactive)
  "write the contents of *scratch* to the file name persistent-scratch-filename, making a backup copy in persistent-scratch-backup-directory"
  (with-current-buffer (get-buffer "*scratch*")
    (if (file-exists-p persistent-scratch-filename)
        (copy-file persistent-scratch-filename
                   (concat persistent-scratch-backup-directory "persistent-scratch")
                   "overwrite"))
    (write-region (point-min) (point-max)
                  persistent-scratch-filename)

    (kuba-git-operation persistent-scratch-backup-directory)
    ))

(defun kuba-git-operation (dir)
  "run git"
  (let ((default-directory dir))
    (shell-command (format "git commit -a -m 'auto saved scratch file'"))))

(defun load-persistent-scratch ()
  (if (file-exists-p persistent-scratch-filename)
      (with-current-buffer (get-buffer "*scratch*")
        (delete-region (point-min) (point-max))
        (shell-command (format "cat %s" persistent-scratch-filename) (current-buffer)))))

(defun scratch-remap-save-key ()
  (with-current-buffer (get-buffer "*scratch*")
    (setq scratchmap (make-sparse-keymap))
    (use-local-map scratchmap)
    (local-set-key (kbd "C-x C-s") 'save-persistent-scratch)))


(scratch-remap-save-key)


(load-persistent-scratch)

(push #'save-persistent-scratch kill-emacs-hook)

(defun dvorak-mode ()
  (interactive)
  (if (equal current-input-method nil)
  (progn
    (defadvice switch-to-buffer (after activate-input-method activate)
      (activate-input-method "english-dvorak"))
    (set-input-method "english-dvorak")
    (add-hook 'minibuffer-setup-hook (lambda () (set-input-method "english-dvorak"))))
  
  (progn
    (defadvice switch-to-buffer (after activate-input-method activate)
      (activate-input-method nil))
    (set-input-method nil)
    (remove-hook 'minibuffer-setup-hook (lambda () (set-input-method "english-dvorak"))))
  ))

 ;; (defun colemak-mode ()
 ;;  (interactive)
 ;;  (if (equal current-input-method nil)
 ;;  (progn
 ;;    (defadvice switch-to-buffer (after activate-input-method activate)
 ;;      (activate-input-method "english-colemak"))
 ;;    (set-input-method "english-colemak")
 ;;    (add-hook 'minibuffer-setup-hook (lambda () (set-input-method "english-colemak"))))
  
 ;;  (progn
 ;;    (defadvice switch-to-buffer (after activate-input-method activate)
 ;;      (activate-input-method nil))
 ;;    (set-input-method nil)
 ;;    (remove-hook 'minibuffer-setup-hook (lambda () (set-input-method "english-colemak"))))
 ;;  ))


(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))


(set-exec-path-from-shell-PATH)

(setq my-scratch-timer (run-with-idle-timer 600 1 'save-persistent-scratch))

(message "Scratch timer set up: " my-scratch-timer)

(require 'engine-mode)

(engine/set-keymap-prefix (kbd "C-c s"))

(engine-mode)

;(define-key haskell-mode-map "\C-ch" 'haskell-hoogle)

(defengine google
  "https://www.google.com/#q=%s"
  :keybinding "g")

(defengine github
  "https://github.com/search?ref=simplesearch&q=%s")

(defengine hoogle
  "https://www.haskell.org/hoogle/?hoogle=%s")

(defengine stack-overflow
  "https://stackoverflow.com/search?q=%s")

(defengine twitter
  "https://twitter.com/search?q=%s"
  :keybinding "t")

(defengine wikipedia
  "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s"
  :keybinding "w"
  :docstring "Searchin' the wikis.")

(defengine wiktionary
  "https://www.wikipedia.org/search-redirect.php?family=wiktionary&language=en&go=Go&search=%s")

(defengine wolfram-alpha
  "http://www.wolframalpha.com/input/?i=%s")

(defengine youtube
  "http://www.youtube.com/results?aq=f&oq=&search_query=%s"
  :keybinding "y"
  )

(setq haskell-hoogle-command "/Users/kt/.local/bin/hoogle")

;(do-applescript "tell application \"Google Chrome\"
;	activate
;	set active tab index of first window to 1
;	
;	tell application \"System Events\" to keystroke \"/\"
;end tell")
;
;(defun gmail-search (s)
;  (interactive "sEnter query: ")
;  
;  (do-applescript (format "tell application \"Google Chrome\" to open location \"https://mail.google.com/mail/u/0/#search/%s\"" s)))
;(global-set-key (kbd "C-x m") 'gmail-search)
;

(require 'wconf)

(require 'mouse)

(xterm-mouse-mode t)

(defun track-mouse (e))

(setq mouse-sel-mode t)

;dired+

;docker

;Dropbox

;find-file-in-project

;hackernews

;hl-line+

;ibuffer-git

;org-mode

;osx-browse

;ruby-block

                                        ;hoogle

(add-hook 'after-init-hook (lambda () (load-theme 'zenburn t)))


(add-hook 'after-init-hook (lambda () (wconf-load "/home/kt/.emacs.d/wconf-window-config.el")))



(load-theme 'zenburn t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (multishell multi-eshell eshell-git-prompt yaml-mode json-mode wconf window-layout layout-restore zenburn-theme typing spaceline smex shell-switcher rvm ruby-block popup-kill-ring osx-browse org magit-tramp magit-annex intero ibuffer-git helm-hoogle hackernews google-this find-file-in-repository engine-mode dropbox docker-api docker dired+ crosshairs command-t bundler btc-ticker browse-kill-ring autopair auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
