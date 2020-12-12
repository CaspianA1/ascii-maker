;;;; ascii-maker.asd

(asdf:defsystem #:ascii-maker
  :description "Make ASCII art from PNG, JPEG, GIF, and TIFF files."
  :author "Caspian Ahlberg <caspianahlberg@gmail.com>"
  :license "Apache License"
  :version "0.0.1"
  :serial t
  :depends-on (#:opticl #:cl-ppcre)
  :components ((:file "package")
               (:file "ascii-maker")))