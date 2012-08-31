;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |russian doll|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp") (lib "arrow-gui.ss" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp") (lib "arrow-gui.ss" "teachpack" "htdp")))))
;checkings
(check-expect (depth (make-layer "yellow" (make-layer "green" "red")))
              3)
(check-expect (depth "red") 1)
(check-expect (colors (make-layer "yellow" (make-layer "green" "red")))
              "yellow, green, red")
(check-expect (inner (make-layer "yellow" (make-layer "green" "red"))) "red")

;An RD (russian doll) is one of:
; - String
; - (make-layer String RD)
(define-struct layer (color doll))

;RD -> Number
;how many dolls are a part of an-rd
(define (depth an-rd)
  (cond
    [(string? an-rd) 1]
    [(layer? an-rd) (add1 (depth (layer-doll an-rd)))]))

;RD -> String-of-Colors
;Mostra as cores das bonecas russas
(define (colors doll)
  (cond
    [(string? doll) doll]
    [(layer? doll)
     (string-append (layer-color doll)
                    ", " 
                    (colors (layer-doll doll)))]))

;RD -> RD
;Consume uma boneca e mostra a camada mais interna
(define (inner rd)
  (cond
    [(string? rd) rd]
    [(layer? rd)
     (inner (layer-doll rd))]))