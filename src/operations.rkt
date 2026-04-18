#lang racket

(require "./custom-exception.rkt")
(provide suma resta multiplicacion division)

; Suma
(define (suma a b)
  (+ a b))

; Resta
(define (resta a b)
  (- a b))

; Multiplicación
(define (multiplicacion a b)
  (* a b))

; División -> maneja la división por cero con nuestra custom exception
(define (division a b)
  (if (= b 0)
      (raise (division-por-cero-error 
              "no se puede dividir entre cero"
              (current-continuation-marks)))
      (/ a b)))

