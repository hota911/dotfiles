(add-to-list 'load-path "/home/hiroyuki/.emacs.d/")
;;; ln -s ~/Dropbox/emacs.el ~/.emacs.el

;;; killringとclipboardの同期
(setq x-select-enable-clipboard t)

;;起動時の画面を消す
(setq inhibit-startup-message t)

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)


;; 日本語入力モードで楽するために
;; 調べるためには M-x describe-key
(define-key global-map "\C-x\C-k" 'kill-buffer)
(define-key global-map "\C-x\C-o" 'other-window)
(define-key global-map "\C-x\C-b" 'switch-to-buffer)
(define-key global-map "\C-x B" 'list-buffers)

;; バッファを再読み込み
;; (define-key global-map "\C-x\C-r" 'revert-buffer)



(defun word-count (&optional start end)
  "Print number of lines, words and characters in the region."
  (interactive "r")
  (let ((b (if mark-active start (point-min)))
	(e (if mark-active end (point-max))))
    (message "Region has %d lines, %s words, %d characters"
             (count-lines b e) (how-many "\\w+" b e) (- e b))))
(global-set-key "\M-=" 'word-count)

;; ========================== Appearance ==========================

;; Remove scroll bar, menu bar and tool bar in display mode.
(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)
      (menu-bar-mode -1)
      (scroll-bar-mode -1)))

;; 列番号
(column-number-mode t)

;; 等幅フォント



;; ColorTheme
;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-arjen)

;; (setq default-frame-alist
;;       (append (list
;;                '(width . 111)
;;                '(height . 36)
;;                '(top . 366)
;;                '(left . 335)
;;                '(alpha . (nil 85 50 30))
;;                )
;;               default-frame-alist))


;; ==========================spell check==========================

;; スペルチェッカとしてaspellを指定
(setq-default ispell-program-name "aspell")
;; 日本語混じりのTeX文書でスペルチェック
(eval-after-load "ispell"
'(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
;;; Spell Check
(global-set-key "\C-csc" 'ispell-buffer)
;;; Spell Check Word
(global-set-key "\C-csw" 'ispell-word)

;; YaTeX起動時に，flyspell-modeも起動する
(add-hook 'yatex-mode-hook 'flyspell-mode)
(custom-set-variables
'(flyspell-auto-correct-binding [(control ?\:)]))
 
;; ==========================折り返し==========================
;; 折り返し時のカーソルの上下移動の動作
;; http://homepage1.nifty.com/alchemy/os_x/emacs.html#par3

(defun screen-column ()
  "Get the screen column position"
  (save-excursion
    (let ((my-column (current-column)))
      (vertical-motion 0)
      (- my-column (current-column)))))

(defun next-screen-line ()
  "next screen line"
  (interactive)
  (if truncate-lines
      (next-line 1)
    (if (not (eq last-command 'next-screen-line))
        (setq goal-screen-column (screen-column)))
    (vertical-motion 0)
    (vertical-motion 1)
    (move-to-column (+ (current-column) goal-screen-column))))

(defun previous-screen-line ()
  "previous screen line"
  (interactive)
  (if truncate-lines
      (previous-line 1)
    (if (not (eq last-command 'next-screen-line))
        (setq goal-screen-column (screen-column)))
    (vertical-motion 0)
    (vertical-motion -1)
    (move-to-column (+ (current-column) goal-screen-column)))
  (setq this-command 'next-screen-line))

(defun beginning-of-screen-line ()
  "beginning of screen line"
  (interactive)
  (vertical-motion 0))

(defun end-of-screen-line ()
  "end of screen line"
  (interactive)
  (vertical-motion 1)
  (if (not (eobp))
      (backward-char 1)))

(defvar goal-screen-column nil)

;;(global-set-key "¥C-p" 'previous-screen-line)
;;(global-set-key "¥C-n" 'next-screen-line)
;;(global-set-key "¥C-e" 'beginning-of-screen-line)
;;(global-set-key "¥C-a" 'end-of-screen-line)

(global-set-key [up] 'previous-screen-line)
(global-set-key [down] 'next-screen-line)


;; toggle fullscreen
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
			 (if (equal 'fullboth current-value)
			     (if (boundp 'old-fullscreen) old-fullscreen nil)
			   (progn (setq old-fullscreen current-value)
				  'fullboth)))))
(global-set-key [f11] 'toggle-fullscreen)


(set-default-font "Inconsolata:pixelsize=14:spacing=0")
;(set-face-font 'variable-pitch "Inconsolata")
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0208
                  '("Takaoゴシック" . "unicode-bmp")
)

;; MEPLA
;; http://ergoemacs.org/emacs/emacs_package_system.html
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

;; Go lang
(require 'auto-complete) 
(require 'go-autocomplete)
(require 'go-eldoc)
(setq gofmt-command "goimports")
(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'before-save-hook 'gofmt-before-save)

(setq default-tab-width 4)
(setq js-indent-level 2)


;; Copy Env variables
;; https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


;; Markdown
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;; Show line numbers.
(linum-mode 1)

;; http://qiita.com/t2psyto/items/05776f010792ba967152
(setq default-directory "~/") 
(setq command-line-default-directory "~/")
