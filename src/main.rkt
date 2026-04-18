#lang racket

(require "./operations.rkt")
(require "./custom-exception.rkt")

(define (leer-numero mensaje)
  (display mensaje)
  (let ([valor (read)])
    (if (number? valor)
        valor
        (raise (entrada-no-numerica-error 
                "No se ingresó un número válido." 
                (current-continuation-marks))))))

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
             (with-handlers ([entrada-no-numerica-error?
                              (lambda (e)
                                (display "\nError: ")
                                (displayln (exn-message e))
                                (loop))])
               (let ((a (leer-numero "Ingresa valor 'a': ")))
                 (let ((b (leer-numero "Ingresa valor 'b': ")))
                   (display "\nResultado: ")
                   (displayln (suma a b))
                   (loop))))))
          
          ((= opcion 2)
          ; resta
           (begin
             (with-handlers ([entrada-no-numerica-error?
                              (lambda (e)
                                (display "\nError: ")
                                (displayln (exn-message e))
                                (loop))])
               (let ((a (leer-numero "Ingresa valor 'a': ")))
                 (let ((b (leer-numero "Ingresa valor 'b': ")))
                   (display "\nResultado: ")
                   (displayln (resta a b))
                   (loop))))))
          
          ((= opcion 3)
          ; multiplicación
           (begin
             (with-handlers ([entrada-no-numerica-error?
                              (lambda (e)
                                (display "\nError: ")
                                (displayln (exn-message e))
                                (loop))])
               (let ((a (leer-numero "Ingresa valor 'a': ")))
                 (let ((b (leer-numero "Ingresa valor 'b': ")))
                   (display "\nResultado: ")
                   (displayln (multiplicacion a b))
                   (loop))))))
          
          ((= opcion 4)
           ; división
           (with-handlers ([entrada-no-numerica-error?
                            (lambda (e)
                              (display "\n¡Error de entrada!: ")
                              (displayln (exn-message e))
                              (loop))]
                           [division-por-cero-error?
                            (lambda (e)
                              (display "\n¡Error matemático!: ")
                              (displayln (exn-message e))
                              (loop))])
             (let ((a (leer-numero "Ingresa valor 'a': ")))
               (let ((b (leer-numero "Ingresa valor 'b': ")))
                 (display "\n[Resultado: ")
                 (display (division a b))
                 (display "]\n")
                 (loop)))))
          
          ((= opcion 5)
           (display "\nPrograma Terminado\n"))
          
          (else
           (begin
             (display "\nOpción inválida.\n")
             (loop))))))))

(menu)