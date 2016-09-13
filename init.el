(server-start)
(package-initialize)

(global-set-key [f10] '(lambda () (interactive) (switch-to-buffer "*scratch*")))

(global-set-key (kbd "C-x C-b") 'ibuffer) 
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-c C-k") 'compile)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "M-X") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(global-set-key "\M-y" 'popup-kill-ring)
                                        ;(global-set-key (kbd "C-x g") 'google-this-mode-submap)

(hl-line-mode)

(display-time)
(defalias 'list-buffers 'ibuffer)
(desktop-save-mode t)
(show-paren-mode t)
(follow-mode t)


(autoload 'ruby-mode "ruby-mode" "Ruby Mode." t)

(require 'package)
(require 'tramp)


(add-to-list 'tramp-default-method-alist '("192.168.4.44" "" "telnet"))
(add-to-list 'tramp-default-method-alist '("192.168.4.100" "" "ftp"))
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
                          rvm
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


(setq my-timer (run-with-idle-timer 240 1 'refresh-hackernews))
(setq tramp-default-method "ssh")


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
  "create a filename to backup the current scratch file by concatenating persistent-scratch-backup-directory with the current date and time"
  (concat
   persistent-scratch-backup-directory
   (replace-regexp-in-string
    (regexp-quote " ") "-" (current-time-string))))

(defun save-persistent-scratch ()
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

(define-key haskell-mode-map "\C-ch" 'haskell-hoogle)

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

(defun gmail-search (s)
  (interactive "sEnter query: ")
  
  (do-applescript (format "tell application \"Google Chrome\" to open location \"https://mail.google.com/mail/u/0/#search/%s\"" s)))
(global-set-key (kbd "C-x m") 'gmail-search)




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
(load-theme 'zenburn t)

