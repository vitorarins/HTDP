;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname dotscene) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp")))))
; visual constants
(define MTS (empty-scene 100 100))
(define BLU (place-image (rectangle 25 25 "solid" "blue") 50 50 MTS))
(define DOT (circle 3 "solid" "red"))
 
; Posn Image -> Image
; adds a red spot to s at p
 
(check-expect (scene+dot (make-posn 10 20) MTS)
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73) BLU)
              (place-image DOT 88 73 BLU))
 
(define (scene+dot p BLU)
  (place-image DOT (posn-x p) (posn-y p) s))
(big-bang 0
          (on-click scen
