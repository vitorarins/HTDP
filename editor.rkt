;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname editor) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp")))))
;constants definitions
(define WIDTH 200)
(define HEIGHT 20)
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 20 "solid" "red"))
(define (string-delete s) (substring s 0 (sub1(string-length s))))

;checkings
(check-expect (direita (make-editor "hell" "oworld")) (make-editor "hello" "world"))
(check-expect (esquerda (make-editor "hellow" "orld")) (make-editor "hello" "world"))
;(check-expect (render (make-editor "hel" "llo world")) (place-image 
;                                                        (beside (st-txt "hel")
;                                                                CURSOR
;                                                                (text "llo world" 11 "black")) 35 10 MT))

;functions definitions
(define (direita ed) 
  (make-editor (string-append (editor-pre ed) (string-ith (editor-post ed) 0)) (substring (editor-post ed) 1 (string-length (editor-post ed)))))
(define (esquerda ed)
  (make-editor (substring (editor-pre ed) 0 (sub1 (string-length (editor-pre ed)))) (string-append (string-ith (editor-pre ed) (sub1 (string-length (editor-pre ed)))) (editor-post ed))))

(define (st-txt s) (text s 11 "black"))
(define-struct editor (pre post))
;Editor = (make-editor String String)
;interp. (make-editor s t) means the text in the editor is
;(string-append s t) with the cursor displayed between s and t
(define (edit ed ke)
  (cond 
    [(string=? ke "\b") (make-editor (string-delete (editor-pre ed)) (editor-post ed))]
    [(or (string=? ke "\t") (string=? ke "\u007F")) (make-editor (editor-pre ed) (editor-post ed))]
    [(string=? ke "right") (direita ed)]
    [(string=? ke "left") (esquerda ed)]
    [else (make-editor (string-append (editor-pre ed) ke) (editor-post ed))]))
(define (imagem ed)
  (beside (st-txt (editor-pre ed))
                             CURSOR
                             (st-txt (editor-post ed))))
(define (render ed) (place-image (imagem ed) (/ (image-width (imagem ed)) 2) 10 MT))

;main function
(define (run s)
  (big-bang (make-editor s "")
            (on-key edit)
            (to-draw render)))
(run "hell")