# Taller 1: Lenguajes de Programación

## 1. Información General
* **Propósito del programa:** El programa consiste en una calculadora interactiva que se ejecuta a través de la terminal. Permite al usuario realizar operaciones matemáticas básicas (suma, resta, multiplicación y división) mediante un menú.
* **Lenguaje de programación:** Racket.
* **Estructura de archivos:** El proyecto sigue la jerarquía solicitada y separa la lógica de las operaciones y las excepciones para mantener un código modular.
  * `Taller1-{ID}.zip`
    * `README.md`: Archivo de documentación.
    * `src/`: Carpeta que contiene el código fuente.
      * `main.rkt`: Programa principal que contiene el menú interactivo y el manejo de excepciones.
      * `operations.rkt`: Módulo que contiene la lógica matemática de las operaciones.
      * `custom-exception.rkt`: Módulo donde se define la estructura de la excepción personalizada.

## 2. Guía de Uso
* **Ejecución:** Para iniciar el programa, el usuario debe compilar o ejecutar el archivo `main.rkt`.
* **Interacción:** El programa desplegará un menú principal con 5 opciones numeradas. El usuario debe ingresar el número correspondiente a la acción que desea realizar.
* **Tipos de entradas aceptadas:**
  * Para el menú: Números enteros del 1 al 5.
  * Para los operandos (valores 'a' y 'b'): Valores numéricos (enteros o reales).
* **Posibilidades y escenarios:**
  * **Flujo normal:** Si el usuario ingresa números válidos, el programa calculará el resultado, lo imprimirá en pantalla y volverá a mostrar el menú.
  * **Entrada no numérica (Validación general):** Si el usuario ingresa un carácter o texto cuando se espera un número (tanto en el menú como en los operandos), el sistema capturará el error de forma nativa e imprimirá el mensaje `"Error: Ingrese un número válido"`, retornando al menú sin cerrarse forzosamente.
  * **Opción fuera de rango:** Si se ingresa un número distinto a las opciones 1-5, el programa indicará `"Opción inválida"` y solicitará un nuevo input.
  * **Salida:** Al ingresar la opción 5, el programa finaliza su ejecución imprimiendo `"Programa Terminado"`.

## 3. Excepción Personalizada
* **Nombre:** `division-por-cero-error`
* **Gatillos:** La excepción se lanza exclusivamente dentro de la función `division` (ubicada en `operations.rkt`) cuando el sistema detecta que el usuario ha ingresado el valor `0` para el operando `b` (el divisor).
* **Componentes:** Es una estructura (`struct`) que hereda de `exn:fail:user`, la cual es una clase base en Racket diseñada para errores generados por el usuario.
  * Al elevarse (`raise`), recibe un mensaje descriptivo (`"no se puede dividir entre cero"`) y las marcas de continuación actuales (`current-continuation-marks`) para rastrear el contexto del error.
* **Funcionamiento:** 1. Al intentar dividir por cero, la función matemática detiene su ejecución inmediatamente y lanza la excepción.
  2. El control del programa regresa al archivo principal `main.rkt`.
  3. El bloque `with-handlers` configurado en la opción 4 del menú intercepta específicamente el tipo `division-por-cero-error?`.
  4. El handler extrae el mensaje de la excepción mediante `exn-message` y lo muestra en pantalla al usuario.
* **Objetivo:** El objetivo principal de esta excepción es prevenir que el programa intente realizar una operación matemáticamente indefinida, lo cual causaría un fallo crítico a nivel del intérprete. Al manejarla de esta manera, se asegura la estabilidad del software, permitiendo que el usuario se informe del error y pueda continuar utilizando la calculadora.