.data
	prompt: .asciiz "\nPlease enter a number : "
	even: .asciiz "\nSum of even number is : "
	odd: .asciiz "\nSum of odd number is : "
.text
	
main:

	li $t5, 0 #stores sum of odd number
	li $t4, 0 #stores sum of even number
loop:
	li $v0, 4
	la $a0, prompt 
	syscall
	li $v0, 5
	syscall 
	beq $v0, 0, exitLoop
	move $t1, $v0 
	move $a0, $v0 

	jal isodd

	beq $v0, 1, oddSum
	add $t4, $t4, $t1 
	j loop
	
oddSum:
	add $t5, $t5, $t1
	j loop
	
exitLoop:


	li $v0, 4
	la $a0, even 
	syscall
	li $v0, 1
	move $a0, $t4 
	syscall


	li $v0,	4
	la $a0,	odd 
	syscall
	li $v0,	1
	move $a0, $t5 
	syscall


	li $v0,10 
	syscall


isodd:
	abs $a0, $a0 
	rem $a0,$a0,2 
	move $v0,$a0 
	jr $ra