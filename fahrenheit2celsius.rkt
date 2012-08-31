;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname fahrenheit2celsius) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp") (lib "arrow-gui.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp") (lib "arrow-gui.ss" "teachpack" "htdp")))))
;checkings
(check-expect (f2c* '(32 0 41)) '(0 -17.7 5))

;List-of-Temperatures -> List-of-Temperatures
;converts a Lot to a lot in Celsius
(define (f2c* lot)
  (cond
    [(empty? lot) empty]
    [else (cons (f2c (first lot)) (f2c* (rest lot)))]))

;Number -> Number
;convert a temperature 'f' Fahrenheit to Celsius
(define (f2c f)
  (* 5/9 (- f 32)))