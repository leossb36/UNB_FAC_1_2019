.data
	A: .word 0
	B: .word 0
	print_line: .asciiz "========"
	resp1: .asciiz "\nADD: "
	resp2: .asciiz "\nSUB: "
	resp3: .asciiz "\nAND: "
	resp4: .asciiz "\nOR: "
	resp5: .asciiz "\nXOR: "
	resp6: .asciiz "\nSLL(3): "
	resp7: .asciiz "\nSRL(1): "

	error: .asciiz "\nValor de entrada maior que 255!\nSaindo..."

.text

main:
	# AA and BB, AA or BB, AA xor BB, AA sub BB, AA << 3,  BB >> 1
	jal read_value #leitura de entrada de teclado
	sw $v0, A #salva retorno na word AA
	
	lw $t1, A # corregando dados de AA para variavel de argumento
	jal is_greater_than # checar se AA e maior que 255
	move $s0, $t1 # copia dados para variavel de argumento

	jal read_value
	sw $v0, B
	
	lw $t1, B
	jal is_greater_than
	move $s1, $t1

#fazer as operacoes
	add $t0, $s0, $s1 # AA + BB = CC ($s0)
	sub $t1, $s0, $s1 # AA - BB = CC
	and $t2, $s0, $s1 #bitwise AA . BB = CC
	or $t3, $s0, $s1 #bitwise AA + BB = CC
	xor $t4, $s0, $s1 #bitwise (AA and ~BB) = CC -> p ^ ~q
	sll $t5, $s0, 3 # desloca 3 bits para esquerda em $a0
	srl $t6, $s1, 1 # desloca 1 bit para direita em $a1

	#funcao de print das saidas
	jal print_data
	#finalizando programa/
	j exit_prog

read_value:
	li $v0, 5 #lendo uma valor inteiro de entrada do teclado
	syscall

	jr $ra #retorna valor inteiro

is_greater_than: #if (arg < 255) continue
	slti $t3, $t1, 255  #(arg < 255) -> retorna true ou false
	beq $t2, $t3, exit_prog_error #se t3 for true retorna, se false error 

	jr $ra #retorna valor checado

print_data:
	la $a0, print_line
	
	li $v0, 4 #Chamada de sistema para print de string
	syscall
	
	la $a0, resp1
	
	li $v0, 4 #Chamada de sistema para print de string
	syscall
	
	li $v0, 1 #Chamada de sistema para print de valor
	move $a0, $t0
	syscall

	la $a0, resp2
	
	li $v0, 4 #Chamada de sistema para print de string
	syscall
	
	li $v0, 1 #Chamada de sistema para print de valor
	move $a0, $t1
	syscall
	
	la $a0, resp3
	
	li $v0, 4 #Chamada de sistema para print de string
	syscall
	
	li $v0, 1 #Chamada de sistema para print de valor
	move $a0, $t2
	syscall
	
	la $a0, resp4
	
	li $v0, 4 #Chamada de sistema para print de string
	syscall
	
	li $v0, 1 #Chamada de sistema para print de valor
	move $a0, $t3
	syscall
	
	la $a0, resp5
	
	li $v0, 4 #Chamada de sistema para print de string
	syscall
	
	li $v0, 1 #Chamada de sistema para print de valor
	move $a0, $t4
	syscall

	la $a0, resp6
	
	li $v0, 4 #Chamada de sistema para print de string
	syscall
	
	li $v0, 1 #Chamada de sistema para print de valor
	move $a0, $t5
	syscall

	la $a0, resp7
	
	li $v0, 4 #Chamada de sistema para print de string
	syscall
	
	li $v0, 1 #Chamada de sistema para print de valor
	move $a0, $t6
	syscall
	
	jr $ra
	
exit_prog:
	li $v0, 10 # exit
	syscall

exit_prog_error:
	
	la $a0, error #printa erro

	li $v0, 4
	syscall

	li $v0, 10 # exit
	syscall
