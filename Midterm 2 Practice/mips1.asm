.data
a: .word 5
be: .word 7

.text
main: 
	lw $s0, a
	lw $s1, be
	
	jal greater_than
	
	add $a0, $v0, $zero
	addi $v0, $zero, 1
	syscall 
	
	addi $v0, $zero, 10
	syscall

greater_than:
	add $v0, $zero, $zero
	
	slt $t0, $s0, $s1
	bne $t0, $zero, return
	
	addi $v0, $zero, 1
	
	jr $ra
	
return:
	jr $ra
	