.data
n:      .word 13
m:	.word 20
str1: .asciiz "I love CSE31!"

.text
main: 	add     $t0, $0, $zero
		addi    $t1, $zero, 1
		la      $t3, n
		lw      $t3, 0($t3)
		
fib: 	beq     $t3, $0, finish
		add     $t2,$t1,$t0
		move    $t0, $t1
		move    $t1, $t2
		subi    $t3, $t3, 1
		j       fib
		
finish: addi    $a0, $t0, 0
		addi      $v0, $zero, 1		# you will be asked about the purpose of this line for syscall 
		syscall			
		li      $v0, 10		
		syscall			

