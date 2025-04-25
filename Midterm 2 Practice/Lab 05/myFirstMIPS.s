.data
seven: .word -7
two: .word 2
eight: .word -28
twelve: .word 12

.text
main: 
	addu $t0, $zero, $s0
	
	lw $t1, seven
	addu $t1, $t1, $t0
	
	addu $t2, $t1, $t0
	
	lw $t3, two
	addu $t3, $t3, $t2
	
	addu $t4, $t3, $t2
	
	lw $t5, eight
	addu $t5, $t5, $t4
	
	sub $t6, $t4, $t5
	
	lw $t7, twelve
	addu $t7, $t7, $t6
	
	
	