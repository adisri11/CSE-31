.data
a: .word 5
be: .word 5

.text
main: 
	lw $s0, a
	lw $s1, be
	
	jal equal_to
	
	add $a0, $v0, $zero
	addi $v0, $zero, 1
	syscall
	
	addi $v0, $zero, 10
	syscall
	
equal_to:
	add $v0, $zero, $zero
	
	beq $s0, $s1, return
	
	addi $v0, $zero, 1
	
	jr $ra
	
return:
	jr $ra