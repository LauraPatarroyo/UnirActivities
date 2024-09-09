.data
prompt:      .asciiz "Ingrese la cantidad de numeros a comparar (3-5): "
errorMsg:    .asciiz "Cantidad invalida. Debe ser entre 3 y 5.\n"
inputMsg:    .asciiz "Ingrese un numero: "
resultMsg:   .asciiz "El numero mayor es: "
newline:     .asciiz "\n"

.text
main:
    # Imprimir el mensaje para solicitar la cantidad de n�meros
    li $v0, 4
    la $a0, prompt
    syscall

    # Leer el n�mero ingresado por el usuario
    li $v0, 5
    syscall
    move $t0, $v0  # Guardar la cantidad en $t0

    # Verificar si la cantidad est� en el rango 3-5
    blt $t0, 3, invalid_input
    bgt $t0, 5, invalid_input

    # Inicializar variables
    li $t1, 0          # Contador de n�meros ingresados
    li $t2, -2147483648  # Inicializar el mayor n�mero como el menor valor posible

read_numbers:
    # Imprimir el mensaje para solicitar un n�mero
    li $v0, 4
    la $a0, inputMsg
    syscall

    # Leer el n�mero ingresado por el usuario
    li $v0, 5
    syscall
    move $t3, $v0  # Guardar el n�mero ingresado en $t3

    # Comparar el n�mero ingresado con el mayor actual
    bgt $t3, $t2, update_max

    # Incrementar el contador y verificar si se han ingresado todos los n�meros
    j increment_counter

update_max:
    move $t2, $t3  # Actualizar el mayor n�mero

increment_counter:
    addi $t1, $t1, 1  # Incrementar el contador de n�meros ingresados
    blt $t1, $t0, read_numbers  # Si no se han ingresado todos los n�meros, continuar leyendo

    # Imprimir el resultado
    li $v0, 4
    la $a0, resultMsg
    syscall

    # Imprimir el n�mero mayor
    li $v0, 1
    move $a0, $t2
    syscall

    # Imprimir nueva l�nea
    li $v0, 4
    la $a0, newline
    syscall

    # Terminar el programa
    li $v0, 10
    syscall

invalid_input:
    # Imprimir mensaje de error y volver a pedir la cantidad
    li $v0, 4
    la $a0, errorMsg
    syscall
    j main
