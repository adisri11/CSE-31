.data
	n: .word 25
	str1: .asciiz "Less than\n"
	str2: .asciiz "Less than or equal to\n"
	str3: .asciiz "Greater than\n"
	str4: .asciiz "Greater than or equal to\n"
	input: .asciiz "Input Integer: "
	
.text
	li $v0, 4
	la $a0, input
	syscall
	
	li $v0, 5
	syscall 
	move $t0, $v0
	
	#lw $t1, n
	#slt $t2, $t0, $t1
	#beq $t2, $zero, greater_than_equal
	
	#li $v0, 4
	#la $a0, str1
	#syscall
	#j exit
	
#greater_than_equal:
	#li $v0, 4
	#la $a0, str4
	#syscall
	#j exit
	
	lw $t1, n 
	sgt $t2, $t0, $t1
	beq $t2, $zero, less_or_equal_to
    	
 	li $v0, 4
    	la $a0, str3
    	syscall
    	j exit
    
less_or_equal_to:
    
	li $v0, 4
	la $a0, str2
	syscall
	j exit 
	
	
exit:
	li $v0, 10
	syscall
	