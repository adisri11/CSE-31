.data
a: .word 5
be: .word 3

.text
main:
	lw $s0, a
	lw $s1, be
	
	jal less_than_equal_to
	
	addu $a0, $v0, $zero
	addiu $v0, $zero, 1
	syscall 
	
	addiu $v0, $zero, 10
	syscall
	
less_than_equal_to:
	addu $v0, $zero, $zero
	
	slt $t0, $s1, $s0
	bne $t0, $zero, return
	
	addiu $v0, $zero, 1
	
	jr $ra
	
return:
	jr $ra