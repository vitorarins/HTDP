;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname definestruct) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp")))))
;constants definitions
(define BALL
  (overlay (circle 10 "solid" "green")
           (rectangle 40 2 "solid" "green")))
(define WIDTH 300)
(define HEIGHT 300)
(define MT (empty-scene WIDTH HEIGHT))

;checking
(check-expect 
(move1 (make-ball (make-posn 30 40) (make-vel -10 5))) (make-posn 20 45))

;functions definitions
(define-struct ball (location velocity))
(define-struct vel (deltax deltay))
;(define ball1 (make-ball (make-posn 30 40) (make-vel -10 5)))
(define v1 (make-vel 8 -3))
(define p1 (make-posn 22 80))
(define bola (make-ball p1 v1))
(define (move1 bl) 
  (make-posn 
   (+ (posn-x (ball-location bl)) (vel-deltax (ball-velocity bl)))
  (+ (posn-y (ball-location bl)) (vel-deltay (ball-velocity bl)))))
