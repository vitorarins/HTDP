;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname primeiro) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp")))))
; AllMouseEvts is an element of Image.
  
  ; graphical constants
  (define MT (empty-scene 100 100))
  
  ; clack : AllMouseEvts Number Number String -> AllMouseEvts
  ; add a dot at (x,y) to ws
  
  (check-expect
   (clack MT 10 20 "something mousy")
   (place-image (circle 1 "solid" "red") 10 20 MT))
  
  (check-expect
   (clack (place-image (circle 1 "solid" "red") 1 2 MT) 3 3 "")
   (place-image (circle 1 "solid" "red") 3 3
                (place-image (circle 1 "solid" "red") 1 2 MT)))
  
  (define (clack ws x y action)
    (place-image (circle 1 "solid" "red") x y ws))
  
  ; show : AllMouseEvts -> AllMouseEvts
  ; just reveal the current world state
  
  (check-expect (show MT) MT)
  
  (define (show ws)
    ws)

(big-bang (empty-scene 100 100) (to-draw show) (on-mouse clack))