.data
n: .word 25
str1: .asciiz "Less than\n"
str2: .asciiz "Less than or equal to\n"
str3: .asciiz "Greater than\n"
str4: .asciiz "Greater than or equal to\n"
input: .asciiz "Input integer: "

.text
main: 
	la $v0, 4
	la $a0, input
	syscall
	
	la $v0, 5
	syscall
	
	lw $t0, n
	slt $t1, $v0, $t0
	beq $t1, $zero, greater_than
	j less_than_equal_to
	#beq $t1, $zero, greater_than_equal_to
	
	#la $v0, 4
	#la $a0, str1
	#syscall
	
	#la $v0, 10
	#syscall

#greater_than_equal_to:
	#la $v0, 4
	#la $a0, str4
	#syscall
	
	#la $v0, 10
	#syscall
	
less_than_equal_to:
	la $v0, 4
	la $a0, str2
	syscall
	
	la $v0, 10
	syscall

greater_than:
	beq $v0, $t0, less_than_equal_to
	la $v0, 4
	la $a0, str3
	syscall
	
	la $v0, 10
	syscall
	
	
	


	
	 
	

	
	