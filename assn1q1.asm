.data    
    upperChars:  .asciiz "Alpha", "Bravo", "China", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "India", "Juliet", "Kilo", "Lima", "Mary", "November" ,"Oscar", "Paper", "Quebec", "Research", "Sierra", "Tango", "Uniform", "Victor", "Whisky", "X-ray", "Yankee", "Zulu"
    lowerChars:  .asciiz "alpha", "bravo", "china", "delta", "echo", "foxtrot", "golf", "hotel", "india", "juliet", "kilo", "lima", "mary", "november" ,"oscar", "paper", "quebec", "research", "sierra", "tango", "uniform", "victor", "whisky", "x-ray", "yankee", "zulu"
    indChar:    .word 0, 6, 12, 18, 24, 29, 37, 42, 48, 54, 61, 66, 71, 76, 85, 91, 97, 104, 113, 120, 126, 134, 141, 148, 154, 161
    nums:    .asciiz "zero", "First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Ninth"
    indNumber:  .word 0, 5, 11, 18, 24, 31, 37, 43, 51, 58

    newline: .asciiz "\n"
    
.text
    main:
        while:
	    li, $v0, 12
	    syscall
	    move $t0, $v0
	    
	    li $v0, 4       
	    la $a0, newline  
	    syscall
    	
    	
    	    beq $t0, 63, exit #?
    	    
      	    blt $t0, 58, number #48-57
      	    bgt $t0, 64, char #65-90 97-122
      	    bgt $t0, 57, unknown
      	    
      	    j while
      	
      	exit:
      	    li $v0, 10
            syscall   

      	    
    
    number:
    #48-57
    	blt $t0, 48, unknown  
    	addi $t1, $zero, 48	  	
    	j whileNum
    	
    whileNum:
	beq $t1, $t0, printNum
	addi $t1, $t1, 1
	j whileNum

    printNum:
    	# Get the index
    	subi $t1, $t1, 48
    	mul $t1, $t1, 4
    	la $t2, indChar
    	add $t3, $t1, $t2
    	lw $t4, 0($t3)

        # intermiate address jump
    	la $a0, ($t4) 	    

    	# Get the string address
    	la $t5, lowerChars
    	add $t6, $4, $t5
    	    	
    	li $v0, 4
    	la $a0, ($t6)
    	syscall 
    	
    	li $v0, 4       
	la $a0, newline  
	syscall   
	
	j main
    	
    	
    char:
    	blt $t0, 91, upperChar
    	bgt $t0, 96, lowerChar
    	b unknown
    	
    
    lowerChar:
    #97-122
   	bgt $t0, 122, unknown 
   	addi $t1, $zero, 97	  	
    	j whilelc
    	
    whilelc:
	beq $t1, $t0, printlc
	addi $t1, $t1, 1
	j whilelc

    printlc:
    	# Get the index
    	subi $t1, $t1, 97
    	mul $t1, $t1, 4
    	la $t2, indChar
    	add $t3, $t1, $t2
    	lw $t4, 0($t3)

        # intermiate address jump
    	la $a0, ($t4) 	    

    	# Get the string address
    	la $t5, lowerChars
    	add $t6, $4, $t5
    	    	
    	li $v0, 4
    	la $a0, ($t6)
    	syscall 
    	
    	li $v0, 4       
	la $a0, newline  
	syscall   
	
	j main
    
    upperChar:
    #65-90
   	addi $t1, $zero, 65	  	
    	j whileuc

    whileuc:
	beq $t1, $t0, printuc
	addi $t1, $t1, 1
	j whileuc

    printuc:
    	# Get the index
    	subi $t1, $t1, 65
    	mul $t1, $t1, 4
    	la $t2, indChar
    	add $t3, $t1, $t2
    	lw $t4, 0($t3)

        # intermiate address jump
    	la $a0, ($t4) 	    

    	# Get the string address
    	la $t5, upperChars
    	add $t6, $4, $t5
    	    	
    	li $v0, 4
    	la $a0, ($t6)
    	syscall 
    	
    	li $v0, 4       
	la $a0, newline  
	syscall   
	
	j main
    
    unknown:
    	li $v0, 11 
    	li $a0, 42 #*
    	syscall
    
   	li $v0, 4       
	la $a0, newline  
	syscall
	
    	j main
  