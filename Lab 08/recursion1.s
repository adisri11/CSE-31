.data
prompt: .asciiz "Please enter a number: "
newline:.asciiz "\n"

.text
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall 
	
	move $a0, $v0
	jal recursion
	
	move $a0, $v0
    	li   $v0, 1
    	syscall
    	
    	li   $v0, 4
    	la   $a0, newline
    	syscall
    	li   $v0, 10
    	syscall
    	
recursion: 
	addi $sp, $sp,  -16
    	sw   $ra,  12($sp)
    	sw   $a0,   8($sp)   
    	sw   $s0,   4($sp)
    	sw   $s1,   0($sp)
    	
    	lw   $t0,   8($sp)
    	
    	li $t1, -1
    	beq $t0, $t1, return3
    	
    	li $t1, -2
    	slt $t2, $t0, $t1
    	bne $t2, $zero, return2
    	
    	beq $t0, $t1, return1
    	
    	lw $a0, 8($sp)
    	addi $a0, $a0, -3
    	jal recursion
    	move $s0, $v0
    	
    	lw $a0, 8($sp)
    	addi $a0, $a0, -2
    	jal recursion
    	move $s1, $v0
    	
    	lw   $t3,   8($sp)     
    	add  $t4,   $s0,  $t3  
    	add  $v0,   $t4,  $s1  
    	j    epiloge
    	
return3:
	li $v0, 3
	j epiloge

return2:
	li $v0, 2
	j epiloge

return1:
	li $v0, 1
	j epiloge

epiloge:
	lw   $ra,  12($sp)
    	lw   $a0,   8($sp)   
    	lw   $s0,   4($sp)
    	lw   $s1,   0($sp)
    	addi $sp, $sp,  16
    	jr $ra