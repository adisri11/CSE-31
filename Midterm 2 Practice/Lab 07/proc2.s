.data
x:	.word 5
y:	.word 10
m:	.word 15
b:	.word 2

.text
MAIN:	la $t0, x
	lw $s0, 0($t0)		# s0 = x
	la $t0, y
	lw $s1, 0($t0)		# s1 = y
	
	# Prepare to call sum(x)
	addu $a0, $zero, $s0	# Set a0 as input argument for SUM
	jal SUM
	addu $t0, $s1, $s0
	addu $s1, $t0, $v0
	addiu $a0, $s1, 0 
	li $v0, 1		 
	syscall	
	j END
		
SUM: 	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $a0, 8($sp)
	
	la $t0, m
	lw $s0, 0($t0)		# s0 = m
	addu $a0, $s0, $a0	# Update a0 as new argument for SUB
	jal SUB
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $a0, 8($sp)
	addi $sp, $sp, 12
	
	addu $v0, $a0, $v0
	
	jr $ra		
		
SUB:	la $t0, b
	addiu $sp, $sp -4
	sw $s0, 0($sp)		# Backup s0 from SUM
	lw $s0, 0($t0)		# s0 = b
	subu $v0, $a0, $s0
	lw $s0, 0($sp)		# Restore s0 from SUM
	addiu $sp, $sp 4
	jr $ra

END:
