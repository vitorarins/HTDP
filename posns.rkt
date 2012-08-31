;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname posns) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp")))))
(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))
(check-expect (y- (make-posn 10 -3)) (make-posn 10 -6))
(define (posn-up-x p n)
  (make-posn n (posn-y p)))
(define (posn-up-y p n)
  (make-posn (posn-x p) n))
(define (x+ p)
  (posn-up-x p (+ (posn-x p) 3)))
(define (y- p)
  (posn-up-y p (- (posn-y p) 3)))
