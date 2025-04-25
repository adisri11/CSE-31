.data 
a: .word 5
be: .word 7

.text
main:
	lw $s0, a
	lw $s1, be
	
	jal less_than
	
	add $a0, $v0, $zero
	addi $v0, $zero, 1
	syscall 
	
	addi $v0, $zero, 10
	syscall
	
less_than:
 	add $v0, $zero, $zero
 	
 	slt $t1, $s0, $s1
 	beq $t1, $zero, result
 	
 	addi $v0, $zero, 1
 	
 	jr $ra
 	
 result:
 	
 	jr $ra
 	
 	
