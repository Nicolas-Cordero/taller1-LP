#lang racket

(provide (struct-out division-por-cero-error))

; Excepción personalizada
; Extiende exn:fail:user
(struct division-por-cero-error exn:fail:user ())
