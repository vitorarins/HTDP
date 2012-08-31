;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname carro) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp")))))
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define BODY-LENGTH (+ WHEEL-DISTANCE (* 6 WHEEL-RADIUS)))
(define BODY-HEIGHT (* WHEEL-RADIUS 2))
(define WHL (circle WHEEL-RADIUS "solid" "black"))
(define BDY
  (above
   (rectangle (/ BODY-LENGTH 2) (/ BODY-HEIGHT 2)
              "solid" "red")
   (rectangle BODY-LENGTH BODY-HEIGHT "solid" "red")))
(define SPC (rectangle WHEEL-DISTANCE 1 "solid" "white"))
(define WH* (beside WHL SPC WHL))
(define CAR (underlay/xy BDY WHEEL-RADIUS BODY-HEIGHT WH*))
(define WIDTH 300)
(define HEIGHT 50)
(define Y-CAR 40)
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define TREE
  (underlay/xy (circle 10 'solid 'green)
  9 15
  (rectangle 2 20 'solid 'brown)))
(define (tock ws) (+ ws 3))
(define (render ws)
  (place-image CAR ws Y-CAR(place-image TREE (- WIDTH (image-width TREE)) Y-CAR BACKGROUND)))
(define (end? ws) (if (> ws (- (- WIDTH (image-width TREE)) (/ BODY-LENGTH 2))) true false))


(big-bang -10
          (on-tick tock)
          (to-draw render)
          (stop-when end?))
  