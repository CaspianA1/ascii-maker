(ql:quickload 'opticl)
(ql:quickload 'cl-ppcre)
(defpackage #:ascii-maker
	(:use #:cl #:uiop #:opticl #:ppcre)
	(:export #:make-ascii #:print-ascii))
(in-package #:ascii-maker)

(defun make-ascii (filename)
	(defun image-matches? (frm-regex) (not (null (scan frm-regex filename))))
	(defun image-is-type (frm) (image-matches? (regex-of-format frm)))
	(defun regex-of-format (type)
		(format nil ".+\\.~a$"
			(reduce
				(lambda (c nc) (concatenate 'string c nc))
				(map 'list
				(lambda (c) (format nil "(~a|~a)" c (string-upcase c)))
					type))) type)
	(let
		((ascii-buf (make-array 0 :fill-pointer 0))
		(img (funcall (cond
				((image-matches? ".+\.(j|J)(p|P)(e|E)?(g|G)$") 'read-jpeg-file)
				((image-is-type "png") 'read-png-file)
				((image-is-type "gif") 'read-gif-file)
				((image-is-type "tiff") 'read-tiff-file)
				(:else (lambda (file) (error (format nil "Not a valid image format: ~s" file)))))
			filename))

		(term-height (parse-integer (run-program "tput lines" :output '(:string :stripped t)))))
			(with-image-bounds (height width) img
				(let*
					((num-denom (if (> term-height height)
						(cons term-height height) (cons height term-height)))
					(scale (truncate (/ (car num-denom) (cdr num-denom) 2))))

					(loop for y below height by scale do
						(loop for x below width by scale do
							(vector-push-extend
								(let ((pix (pixel img y x)))
									(if (>= pix 32) (format nil "_~a" (code-char pix)) "██"))
								ascii-buf))
						(vector-push-extend #\linefeed ascii-buf)))
			ascii-buf)))

(defun print-ascii (ascii-buf)
	(loop for i below (length ascii-buf) do
		(princ (aref ascii-buf i))))