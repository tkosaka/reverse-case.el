;;; reverse-case.el --- Reverse case                 -*- lexical-binding: t; -*-

;; Copyright (C) 2015  KOSAKA Tomohiko

;; Author: KOSAKA Tomohiko <tomohiko.kosaka@gmail.com>
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Reverse case.

;;; Code:

(defun reverse-case (ch)
  (let ((case-fold-search nil))
    (if (char-equal (downcase ch) ch)
        (upcase ch)
      (downcase ch))))

(defun reverse-case-string (s)
  (mapconcat 'char-to-string (mapcar 'reverse-case s) ""))

(defun reverse-case-region (beg end)
  (interactive "*r")
  (let (new-ch)
    (goto-char beg)
    (while (< (point) end)
      (setq new-ch (reverse-case (char-after (point))))
      (delete-char 1)
      (insert new-ch))))

(defun reverse-case-word (arg)
  (interactive "*P")
  (unless arg
    (setq arg 1))
  (let ((opoint (point))
        (end-point
         (save-excursion
           (if (> arg 0)
               (search-forward-regexp "\\w+\\b")
             (search-backward-regexp "\\b\\w+"))
           (point))))
    (if (> opoint end-point)
        (rotatef opoint end-point))
    (reverse-case-region opoint end-point)))

(provide 'reverse-case)
;;; reverse-case.el ends here
