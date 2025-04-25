.data
a: .word 7
be: .word 5

.text
main: 
	lw $s0, a
	lw $s1, be
	
	jal greater_than_equal_to
	
	add $a0, $v0, $zero
	addi $v0, $zero, 1
	syscall
	
	addi $v0, $zero, 10
	syscall
	
greater_than_equal_to:
	add $v0, $zero, $zero
	
	slt $t0, $s0, $s1
	bne $t0, $zero, return
	
	addi $v0, $zero, 1
	
	jr $ra
	
return:
	jr $ra