;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname editorindex) (read-case-sensitive #t) (teachpacks ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.ss" "teachpack" "2htdp") (lib "universe.ss" "teachpack" "2htdp") (lib "batch-io.ss" "teachpack" "2htdp")))))
;constants definitions
(define WIDTH 200)
(define HEIGHT 20)
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 20 "solid" "red"))

;checkings
;(check-expect (render (make-editor "hello world" 11)) (place-image 
;                                                        (beside (st-txt "hello world")
;                                                                CURSOR
;                                                                (text "" 11 "black")) 35 10 MT))

;functions definitions
;(define (string-delete s) (substring s 0 (sub1(string-length s))))
(define (st-txt s) (text s 11 "black"))
(define-struct editor (txt idx))
;Editor = (make-editor String Number)
;interp. (make-editor s i) means the text in the editor is 's' 
;with the cursor displayed in the 'i'th position
(define (imagem ed)
  (beside (st-txt (substring (editor-txt ed) 0  (editor-idx ed)))
                       CURSOR
                       (st-txt (substring (editor-txt ed) (editor-idx ed) (string-length (editor-txt ed))))))
(define (render ed) 
  (place-image (imagem ed) (/ (image-width (imagem ed)) 2) 10 MT))

(define (edit ed ke)
  (cond
    [(string=? ke "\b") (make-editor (string-append (substring (editor-txt ed) 0 (sub1 (editor-idx ed))) (substring (editor-txt ed) (editor-idx ed) (string-length (editor-txt ed)))) (sub1 (editor-idx ed)))]
    [(or (string=? ke "\t") (string=? ke "\u007F")) (make-editor (editor-txt ed) (editor-idx ed))]
    [(string=? ke "right") (if (= (editor-idx ed) (string-length (editor-txt ed))) (make-editor (editor-txt ed) (string-length (editor-txt ed))) (make-editor (editor-txt ed) (add1 (editor-idx ed))))]
    [(string=? ke "left") (if (= (editor-idx ed) 0) (make-editor (editor-txt ed) 0) (make-editor (editor-txt ed) (sub1 (editor-idx ed))))]
    [else (make-editor (string-append (string-append (substring (editor-txt ed) 0 (editor-idx ed)) ke) (substring (editor-txt ed) (editor-idx ed) (string-length (editor-txt ed)))) (add1 (editor-idx ed)))]))

;main function
(define (run s)
  (big-bang (make-editor s 0)
            (on-key edit)
            (to-draw render)))
(run "hell")