.data
prompt:      .asciiz "Ingrese la cantidad de numeros a comparar (3-5): "
errorMsg:    .asciiz "Cantidad invalida. Debe ser entre 3 y 5.\n"
inputMsg:    .asciiz "Ingrese un numero: "
resultMsg:   .asciiz "El numero mayor es: "
newline:     .asciiz "\n"

.text
main:
    # Imprimir el mensaje para solicitar la cantidad de números
    li $v0, 4
    la $a0, prompt
    syscall

    # Leer el número ingresado por el usuario
    li $v0, 5
    syscall
    move $t0, $v0  # Guardar la cantidad en $t0

    # Verificar si la cantidad está en el rango 3-5
    blt $t0, 3, invalid_input
    bgt $t0, 5, invalid_input

    # Inicializar variables
    li $t1, 0          # Contador de números ingresados
    li $t2, -2147483648  # Inicializar el mayor número como el menor valor posible

read_numbers:
    # Imprimir el mensaje para solicitar un número
    li $v0, 4
    la $a0, inputMsg
    syscall

    # Leer el número ingresado por el usuario
    li $v0, 5
    syscall
    move $t3, $v0  # Guardar el número ingresado en $t3

    # Comparar el número ingresado con el mayor actual
    bgt $t3, $t2, update_max

    # Incrementar el contador y verificar si se han ingresado todos los números
    j increment_counter

update_max:
    move $t2, $t3  # Actualizar el mayor número

increment_counter:
    addi $t1, $t1, 1  # Incrementar el contador de números ingresados
    blt $t1, $t0, read_numbers  # Si no se han ingresado todos los números, continuar leyendo

    # Imprimir el resultado
    li $v0, 4
    la $a0, resultMsg
    syscall

    # Imprimir el número mayor
    li $v0, 1
    move $a0, $t2
    syscall

    # Imprimir nueva línea
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
