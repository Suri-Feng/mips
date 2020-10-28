.data
    string: .space 1024
    input: .asciiz "Enter a string: "
    su: .asciiz "Success! Location: "
    fa: .asciiz "Fail!"
    newline: .ascii "\n"


.text 
    main:
    	li $v0, 4
    	la $a0, input
    	syscall
    	
    	li $v0, 8
    	la $a0, string
    	li $a1, 1024
    	syscall 
    	
    	la $t6, string
    	
    	j search
    
    search:
        la $t0, ($t6)
        
    	li $v0, 12
    	syscall 
    	move $t1, $v0
    	
    	beq $t1, 63, exit 
    	li $v0, 4       
	la $a0, newline  
	syscall
	
	addi $s7, $zero, 0 # index counter 
    	j searchLoop
    
    exit:
    	li $v0, 10
    	syscall
    
    searchLoop:
    	lb $t2, ($t0)
    	
    	addi $s7, $s7, 1
    	beq $t2, 0, fail # null char
    	beq $t2, $t1, success
    	add $t0, $t0, 1
    	j searchLoop
   
    success:
        li $v0, 4
    	la $a0, su
    	syscall
    	
    	li $v0, 1
    	add $a0, $zero, $s7
    	syscall
    	
    	li $v0, 4       
	la $a0, newline  
	syscall
    	
    	j search
    	
    
    fail:
    	li $v0, 4 
    	la $a0, fa
    	syscall 
    	
    	li $v0, 4       
	la $a0, newline  
	syscall
    	
    	j search
    
   