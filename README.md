# Taller 1: Lenguajes de Programación
 
## Integrantes - Grupo K:

Nicolás Gonzalo Cordero Varas / 20.543.155-1 

Vicente Alonso Ruiz Escobar / 21.464.046-5

Martín Alejandro Ubilla Briceño / 20.751.624-4

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

## 3. Excepciones Personalizadas
* **Nombre:** `division-por-cero-error`
* **Gatillos:** La excepción se lanza exclusivamente dentro de la función `division` (ubicada en `operations.rkt`) cuando el sistema detecta que el usuario ha ingresado el valor `0` para el operando `b` (el divisor).
* **Componentes:** Es una estructura (`struct`) que hereda de `exn:fail:user`, la cual es una clase base en Racket diseñada para errores generados por el usuario.
  * Al elevarse (`raise`), recibe un mensaje descriptivo (`"no se puede dividir entre cero"`) y se utiliza la instrucción (`current-continuation-marks`) para rastrear el contexto del error.
* **Funcionamiento:** 
1. Al intentar dividir por cero, la función matemática detiene su ejecución inmediatamente y lanza la excepción.
  2. El control del programa regresa al archivo principal `main.rkt`.
  3. El bloque `with-handlers` configurado en la opción 4 del menú intercepta específicamente el tipo `division-por-cero-error?`.
  4. El handler extrae el mensaje de la excepción mediante `exn-message` y lo muestra en pantalla al usuario.
* **Objetivo:** El objetivo principal de esta excepción es prevenir que el programa intente realizar una operación matemáticamente indefinida, lo cual causaría un fallo crítico a nivel del intérprete. Al manejarla de esta manera, se asegura la estabilidad del software, permitiendo que el usuario se informe del error y pueda continuar utilizando la calculadora.

* **Nombre:** `entrada-no-numerica-error`
* **Gatillos:** La exepción se lanza en cualquiera de las operaciones que el usuario seleccione desde el menú, siendo estas `(suma, resta, multiplicación, división)`cuando el sistema detecta un input invalido para las variables `a` o `b`.
*  **Componentes:** Es otra estructura (`struct`) que hereda de `exn:fail:user`.
* **Funcionamiento:**
1. A la hora de ingresar un valor para `a` o para `b`, si se ingresa cualquier carácter o dato que no sea un número, la operación se detiene y se lanza la excepción, volviendo al menú de la calculadora.
2. La función de validación de lectura detecta el tipo de dato incorrecto y utiliza la instrucción `raise` para elevar la excepción y mostrar un mensaje.
3. El bloque with-handlers usa `entrada-no-numerica-error?` para evitar que el error se propague y que se detenga el programa.
4. El handler extrae el mensaje y permite que el programa regrese al inicio del menú interactivo mediante el loop.

* **Objetivo:** Esta excepción busca mantener la integridad de los datos de entrada antes de realizar cálculos aritméticos. Al manejar esta excepción, se previene que el programa falle por una operación inválida entre tipos de datos incompatibles como intentar sumar un número con una letra.
