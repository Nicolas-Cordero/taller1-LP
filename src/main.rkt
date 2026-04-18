#lang racket

(require "./operations.rkt")
(require "./custom-exception.rkt")

; menu loop 
(define (menu)
  (let loop ()
    (display "\n-*-*-MENÚ CALCULADORA-*-*-\n")
    (display "1. Suma\n")
    (display "2. Resta\n")
    (display "3. Multiplicación\n")
    (display "4. División\n")
    (display "5. Salir\n")
    (display "-*--*-*--*-*--*-*--*-*--*-\n")
    (newline)
    (display "Ingrese una opción: ")
    
    ; manejo no custom, chequea que el input sea numero.
    (with-handlers ((exn? (lambda (e)
                            (display "\nError: Ingrese un número válido.\n")
                            (loop))))
      (let ((opcion (read)))
        (cond
          ((= opcion 1)
          ; suma
           (begin
             (display "Ingresa valor 'a': ")
             (let ((a (read)))
               (display "Ingresa valor 'b': ")
               (let ((b (read)))
                 (display "\n[Resultado: ")
                 (display (suma a b))
                 (display "]\n")))
             (loop)))
          
          ((= opcion 2)
          ; resta
           (begin
             (display "Ingresa valor 'a': ")
             (let ((a (read)))
               (display "Ingresa valor 'b': ")
               (let ((b (read)))
                 (display "\n[Resultado: ")
                 (display (resta a b))
                 (display "]\n")))
             (loop)))
          
          ((= opcion 3)
          ; multiplicación
           (begin
             (display "Ingresa valor 'a': ")
             (let ((a (read)))
               (display "Ingresa valor 'b': ")
               (let ((b (read)))
                 (display "\n[Resultado: ")
                 (display (multiplicacion a b))
                 (display "]\n")))
             (loop)))
          
          ((= opcion 4)
            ; división
           (begin
             (display "Ingresa valor 'a': ")
             (let ((a (read)))
               (display "Ingresa valor 'b': ")
               (let ((b (read)))
                 (with-handlers ([division-por-cero-error?
                                  (lambda (e)
                                    (display "\n¡Error! ")
                                    (display (exn-message e))
                                    (display "\n"))])
                   (display "\n[Resultado: ")
                   (display (division a b))
                   (display "]\n"))))
             (loop)))
          
          ((= opcion 5)
           (display "\nPrograma Terminado\n"))
          
          (else
           (begin
             (display "\nOpción inválida.\n")
             (loop))))))))

(menu)
