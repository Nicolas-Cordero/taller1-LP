#lang racket

(provide (struct-out division-por-cero-error) (struct-out entrada-no-numerica-error))

; Excepción personalizada
; Extiende exn:fail:user
(struct division-por-cero-error exn:fail:user ())
(struct entrada-no-numerica-error exn:fail:user ())
