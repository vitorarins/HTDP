;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname time) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp")))))
;Hour is a Number between 0 and 24
;Minute is a Number between 0 and 60
;Second is a Number between 0 and 60
(define-struct time (hours mins secs))
;Time is (make-time PositiveInteger PositiveInteger PositiveInteger)

(define (time->seconds t) (+ (* (time-hours t) 3600) (* (time-mins t) 60) (time-secs t)))
(time->seconds (make-time 12 30 2))