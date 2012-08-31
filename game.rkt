;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname game) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp")))))
(define WIDTH 300)
(define HEIGHT 300)
(define MT (empty-scene WIDTH HEIGHT))
(define UFO
  (overlay (circle 10 "solid" "green")
           (rectangle 40 2 "solid" "green")))
(define TANK
  (underlay (rectangle 40 10 "solid" "blue")
            (triangle 15 "solid" "red")))
(define MIS (triangle 10 "solid" "red"))

;functions definitions
;A SIGS (Space Invader Game State) is one of:
; - (make-aim UFO Tank)
; - (make-fired UFO Tank Missile)
(define-struct aim (ufo tank))
(define-struct fired (ufo tank miss))


;A UFO is a POSN
;interp. (make-posn x y) isthe UFO's current locations

;A Tank is (make-tank Number Number).
;interp. (make-tank x dx) means the tank is at (x, HEIGHT)
; and that it moves dx pixels per key press
(define-struct tank (loc vel))

;A Missile is Posn.
;interp. (make-posn x y) is the missile's current location

;Tank Image -> Image
;add t to the given image im
(define (tank-render t im) (place-image TANK (tank-loc t) HEIGHT im))

;UFO Image -> Image
;add u to the given image im
(define (ufo-render u im) (place-image UFO (posn-x u) (posn-y u) im))

;Missile Image -> Image
;add m to the given image im
(define (missile-render m im) (place-image MIS (posn-x m) (posn-y m) im))

;SIGS -> Image
;to add TANK, UFO, and possibly the MIS to MT
(define (si-render s) 
  (cond
    [(aim? s) 
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) MT))]
    [(fired? s)
     (tank-render (fired-tank s) 
                  (ufo-render (fired-ufo s)
                              (missile-render (fired-miss s) MT)))]))
;UFO Missile -> Boolean
;to say if the UFO was hitted
(define (hit s)
  (if (and (<= (- (posn-x (fired-ufo s))
                  (image-width UFO))
               (posn-x (fired-miss s))
               (+ (posn-x (fired-ufo s))
                  (image-width UFO)))
           (<= (- (posn-y (fired-ufo s))
                  (image-height UFO))
               (posn-y (fired-miss s)) 
               (+ (posn-y (fired-ufo s))
                  (image-height UFO))))
      true false))

;SIGS -> Boolean
;to say if the game is over
(define (si-game-over? s)
  (cond
    [(aim? s)
     (if (>= (posn-y (aim-ufo s)) HEIGHT)
         true 
         false)]
    [(fired? s) 
     (if (= (posn-y (fired-ufo s)) HEIGHT)
         true 
         (hit s))]))

;SIGS Time -> SIGS
;it transforms the state 's' as time goes by
(define (si-move s)
  (cond
    [(aim? s) 
     (make-aim (make-posn (if (odd? (random 100)) 
                              (+ (posn-x (aim-ufo s)) 3) 
                              (- (posn-x (aim-ufo s)) 3)) 
                          (+ (posn-y (aim-ufo s)) 3))
               (make-tank (tank-loc (aim-tank s)) 
                          (tank-vel (aim-tank s))))]
    [(fired? s) 
     (make-fired 
                 (make-posn (if (odd? (random 100))
                                (+ (posn-x (fired-ufo s)) 3) 
                                (- (posn-x (fired-ufo s)) 3)) 
                            (+ (posn-y (fired-ufo s)) 3)) 
                 (make-tank (tank-loc (fired-tank s))
                            (tank-vel (fired-tank s))) 
                 (make-posn (posn-x (fired-miss s)) (- (posn-y (fired-miss s)) 25)))]))

;SIGS Key -> SIGS
;it transforms the state 's' as a key 'ke' is pressed.
(define (si-control s ke)
  (cond
    [(aim? s)
     (cond
       [(string=? ke "right") 
        (make-aim (make-posn (posn-x (aim-ufo s))
                             (posn-y (aim-ufo s))) 
                  (make-tank (+ (tank-loc (aim-tank s))
                                (tank-vel (aim-tank s)))
                             (tank-vel (aim-tank s))))]
       [(string=? ke "left") 
        (make-aim (make-posn (posn-x (aim-ufo s))
                             (posn-y (aim-ufo s)))
                  (make-tank 
                   (- (tank-loc (aim-tank s))
                      (tank-vel (aim-tank s)))
                   (tank-vel (aim-tank s))))]
       [(string=? ke " ")
        (make-fired (make-posn (posn-x (aim-ufo s))
                               (posn-y (aim-ufo s)))
                    (make-tank (tank-loc (aim-tank s))
                               (tank-vel (aim-tank s)))
                    (make-posn (tank-loc (aim-tank s))
                               (- HEIGHT (image-height TANK))))]
       [else (make-aim (make-posn (posn-x (aim-ufo s))
                                  (posn-y (aim-ufo s)))
                       (make-tank (tank-loc (aim-tank s))
                                  (tank-vel (aim-tank s))))])]
    [(fired? s)
     (cond
       [(string=? ke "right") 
        (make-fired (make-posn (posn-x (fired-ufo s))
                             (posn-y (fired-ufo s))) 
                  (make-tank (+ (tank-loc (fired-tank s))
                                (tank-vel (fired-tank s)))
                             (tank-vel (fired-tank s)))
                  (make-posn (posn-x (fired-miss s))
                             (posn-y (fired-miss s))))]
       [(string=? ke "left") 
        (make-fired (make-posn (posn-x (fired-ufo s))
                             (posn-y (fired-ufo s)))
                  (make-tank (- (tank-loc (fired-tank s))
                                (tank-vel (fired-tank s)))
                             (tank-vel (fired-tank s)))
                  (make-posn (posn-x (fired-miss s))
                             (posn-y (fired-miss s))))]
       [else 
        (make-fired (make-posn (posn-x (fired-ufo s))
                                  (posn-y (fired-ufo s)))
                       (make-tank (tank-loc (fired-tank s))
                                  (tank-vel (fired-tank s)))
                       (make-posn (posn-x (fired-miss s))
                                  (posn-y (fired-miss s))))])]))

;Main function
(define (run v)
  (big-bang (make-aim (make-posn (/ WIDTH 2) 
                                 20)
                      (make-tank (/ WIDTH 2)
                                 v))
            (on-key si-control)
            (on-tick si-move 1)
            (to-draw si-render)
            (stop-when si-game-over?)))
(run 3)