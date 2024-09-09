.data #Define datos y variables
prompt_input:  .asciiz  "Ingrese cu�ntos n�meros de la serie Fibonacci desea generar: "
fibonacci_res: .asciiz "La serie de Fibonacci es: "
sum_res:       .asciiz "\nLa suma de los n�meros de la serie es: "

newline:       .asciiz "\n"

.text #Instrucciones del programa
.globl main # variable global
main:

    # Solicitar al usuario la cantidad de n�meros de Fibonacci a generar
    li $v0, 4                # syscall para imprimir cadena
    la $a0, prompt_input      # cargar el mensaje de entrada
    syscall
    
    li $v0, 5                # syscall para leer un entero
    syscall
    move $t0, $v0            # almacenar el n�mero ingresado en $t0 (n�mero de t�rminos de Fibonacci)
    
    # Verificar si la cantidad es mayor que 0
    blez $t0, exit           # si el n�mero ingresado es <= 0, salir del programa

  # Imprimir un espacio entre n�meros
    li $v0, 4
    la $a0, newline
    syscall
    
    # Imprimir mensaje de resultado de la serie
    li $v0, 4
    la $a0, fibonacci_res
    syscall
    
  # Imprimir un espacio entre n�meros
    li $v0, 4
    la $a0, newline
    syscall
    
    # Inicializaci�n para la serie de Fibonacci
    li $t1, 0                # primer n�mero de Fibonacci (f0)
    li $t2, 1                # segundo n�mero de Fibonacci (f1)
    move $t3, $t1            # inicializar suma (acumulador)
    
    # Imprimir el primer n�mero (f0)
    li $v0, 1                # syscall para imprimir entero
    move $a0, $t1            # cargar el primer n�mero (0) en $a0
    syscall

    # Comenzar el ciclo para calcular los siguientes n�meros
    addi $t0, $t0, -1        # restar 1 del n�mero total (ya imprimimos el primer n�mero)
fibonacci_loop:
    beq $t0, $zero, print_sum # si $t0 es 0, ir a imprimir la suma

    # Imprimir un espacio entre n�meros
    li $v0, 4
    la $a0, newline
    syscall

    # Imprimir el siguiente n�mero de la serie
    li $v0, 1
    move $a0, $t2            # cargar el siguiente n�mero (f1, f2, f3, etc.) en $a0
    syscall

    # Actualizar la suma
    add $t3, $t3, $t2        # sumar el n�mero actual a la suma total

    # Calcular el siguiente n�mero de Fibonacci
    add $t4, $t1, $t2        # $t4 = $t1 + $t2 (nuevo Fibonacci)
    move $t1, $t2            # actualizar $t1 al siguiente n�mero
    move $t2, $t4            # actualizar $t2 al siguiente n�mero

    # Decrementar contador y continuar el ciclo
    addi $t0, $t0, -1
    j fibonacci_loop         # saltar al inicio del ciclo

print_sum:

  # Imprimir un espacio entre n�meros
    li $v0, 4
    la $a0, newline
    syscall
    
    # Imprimir la suma de los n�meros de la serie
    li $v0, 4
    la $a0, sum_res
    syscall

    li $v0, 1                # syscall para imprimir entero
    move $a0, $t3            # cargar la suma en $a0
    syscall

  # Imprimir un espacio entre n�meros
    li $v0, 4
    la $a0, newline
    syscall
    
    # Finalizar el programa
exit:
    li $v0, 10               # syscall para salir del programa
    syscall
