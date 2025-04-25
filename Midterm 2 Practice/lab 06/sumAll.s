.data 
	input: .asciiz "Please enter a number: "
	odd: .asciiz "Sum of odd numbers is: "
	even: .asciiz "Sum of even numbers is: "
	newline: .asciiz "\n"
	
.text
main: 
	la $v0, 4
	la $a0, input
	syscall
	
	la $v0, 5
	syscall
	
	addu $s0, $v0, $zero
	beq $s0, $zero, end
	
	rem $t0, $s0, 2
	bne $t0, $zero, odd_sum
	
	addu $s2, $s2, $s0
	
	j main

odd_sum:
	addu $s1, $t0, $s1
	j main
	
	 
end:
	la $v0, 4
	la $a0, even
	syscall
	
	la $v0, 1
	add $a0, $s2, $zero
	syscall
	
	la $v0, 4
	la $a0, newline
	syscall
	
	la $v0, 4
	la $a0, odd
	syscall
	
	la $v0, 1
	add $a0, $s1, $zero
	syscall
	
	la $v0, 10
	syscall 
	
	