(load "ascii-maker.lisp")
(defpackage #:example (:use #:cl #:asdf #:ascii-maker))
(in-package #:example)
(print-ascii (make-ascii "vim.png"))