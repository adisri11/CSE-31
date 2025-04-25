.data
varj: .word 5
k: .word 10
l: .word 15
m: .word 20


.text
main:
	lw $s0, varj
	lw $s1, k
	lw $s2, l
	lw $s3, m
	
	li $t0, 11
	slt $t0, $s0, $t0
	li $t1, 20
	slt $t1, $t1, $s1
	and $t3, $t1, $t0
	slt $t2, $s2, $s3
	xori $t2, $t2, 1
	or $t4, $t3, $t2
	beq $t4, $zero, else
	li $s4, 5
	
	jal print
	
	li $v0, 10
	syscall
	
else:
	li $s4, 10
	
	jal print
	
	li $v0, 10
	syscall
	
print:
	li $v0, 1
	la $a0, 0($s4)
	syscall
	
	