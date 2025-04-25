.data
    a: .word 13
    be: .word 5

.text
main: 
    lw $a0, a
    lw $a1, be

    jal func1
    
    la $a0, 0($v0)
    li $v0, 1
    syscall
    
    li $v0, 10
    syscall

func1: 
    addi $sp, $sp, -12
    sw $ra, 12($sp)
    sw $a0, 8($sp)
    sw $a1, 4($sp)
    
    div $a0, $a1
    mfhi $s0
    
    add $a1, $s0, $a1
    
    jal func2

    lw $ra, 12($sp)
    lw $a0, 8($sp)
    lw $a1, 4($sp)
    addi $sp, $sp, 12

    sub $v0, $v0, $a1
    sub $v0, $v0, $s0

    jr $ra

func2: addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $a0, 8($sp)
    sw $a1, 4($sp)
    sw $s0, 0($sp)

    add $s0, $a0, $a1
    
    mult $s0, $a1
    mflo $v0

    lw $ra, 12($sp)
    lw $a0, 8($sp)
    lw $a1, 4($sp)
    lw $s0, 0($sp)
    addi $sp, $sp, 16
    
    jr $ra
