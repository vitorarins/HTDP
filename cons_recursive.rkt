;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |recursividade cons|) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp")))))
;checking
(check-expect (sum (cons 0 (cons 1 (cons 2 (cons 3 (cons 4 empty)))))) 10)
(check-expect (pos? (cons 0 (cons 1 (cons 2 (cons 3 (cons 4 empty)))))) true)
(check-expect (pos? (cons 0 (cons -1 (cons 2 (cons 3 (cons 4 empty)))))) false)
(check-expect (all-true (cons true (cons true (cons true empty)))) true)
(check-expect (one-true (cons false (cons true (cons false empty)))) true)
(check-expect (all-true (cons false (cons true (cons false empty)))) false)
(check-expect (one-true (cons false (cons false (cons false empty)))) false)
(check-expect (one-true (cons false (cons true (cons true empty)))) true)

(define (sum loa) 
  (cond
    [(empty? loa) 0]
    [else (+ (first loa) (sum (rest loa)))]))

(define (pos? lon)
  (cond
    [(empty? (rest lon)) (if (>= (first lon) 0) true false)]
    [(>= (first lon) 0) (pos? (rest lon))]
    [else false]))

(define (all-true lob)
  (cond
    [(empty? (rest lob)) (boolean=? (first lob) true)]
    [(boolean=? true (first lob)) (all-true (rest lob))]
    [else false]))

(define (one-true lob)
  (cond
    [(empty? (rest lob)) (boolean=? (first lob) true)]
    [(boolean=? (first lob) true) true]
    [else (one-true (rest lob))]))


