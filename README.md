# ascii-maker
### Make ASCII art from PNG, JPEG, GIF, and TIFF files with the power of Common Lisp.

`make-ascii`

Accepts one parameter, `filename`. Will return an array of characters representing an ASCII-fied version of the input image. Print out those characters with `print-ascii`.

Test *ascii-maker* out:

Run `example.lisp` like this: `sbcl --noinform --load ascii-maker.lisp --eval '(quit)'` to get a cool Vim logo!