;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ufo) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp")))))
(define WIDTH 300)
(define HEIGHT 300)
(define CLOSE (/ HEIGHT 3))
(define MT (empty-scene WIDTH HEIGHT))
(define UFO
  (overlay (circle 10 "solid" "green")
           (rectangle 40 2 "solid" "green")))
(define LANDED (- HEIGHT (/ (image-height UFO) 2)))
(define (nxt y)
  (cond
     [(<= 0 y CLOSE)
      (+ y 3)]
     [(and (< CLOSE y) (<= y LANDED))
      (+ y 1.5)]
     [(> y LANDED) 
      (+ y 0)]))
(define (render y)
  (place-image UFO (/ WIDTH 2) y MT))
(define (render/status y)
  (place-image
   (cond
     [(<= 0 y CLOSE)
      (text "descendo" 11 "green")]
     [(and (< CLOSE y) (<= y LANDED))
      (text "aproximando" 11 "orange")]
     [(> y LANDED) 
      (text "mission accomplished!" 11 "red")])
   40 10
   (render y)))
(define (main y0)
  (big-bang y0 (on-tick nxt) (to-draw render/status)))
(main 0)