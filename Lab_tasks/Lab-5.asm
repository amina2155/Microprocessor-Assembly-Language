ORG 100H

.DATA

    INPUT_STATEMENT DB 'Enter 5 digits (0~9):',0DH,0AH,'Input: $'

    ERROR_STATEMENT DB 0DH,0AH,0DH,0AH,'[ ERROR: Invalid Input Detected ]',0DH,0AH,0DH,0AH,'$'
    
    AVG_OUTPUT_STATEMENT DB 0DH,0AH,'Average: $'
    MAX_OUTPUT_STATEMENT DB 0DH,0AH,'Maximum: $'
    MIN_OUTPUT_STATEMENT DB 0DH,0AH,'Minimum: $'
    
    NUMBER_ARRAY DB 5 DUP('$') ;declare an array with a fixed number of value you want to store
    NUMBER_ARRAY_LEN DW 5 ;the number of values you want to store
    
    AVG_VAL DB 00H
    MAX_VAL DB 00H
    MIN_VAL DB 00H  

.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    JMP TAKE_INPUT
    
    INVALID_INPUT: MOV AH, 9
                   MOV DX, OFFSET ERROR_STATEMENT
                   INT 21H
                   
    TAKE_INPUT: MOV AH, 9
                MOV DX, OFFSET INPUT_STATEMENT
                INT 21H
                
                MOV CX, NUMBER_ARRAY_LEN
                MOV DX, OFFSET NUMBER_ARRAY
                CALL READ_NUMBER
                
                MOV CX, NUMBER_ARRAY_LEN
                MOV DX, OFFSET NUMBER_ARRAY
                CALL FIND_AVG
                
                MOV CX, NUMBER_ARRAY_LEN
                MOV DX, OFFSET NUMBER_ARRAY
                CALL FIND_MAX
                
                MOV CX, NUMBER_ARRAY_LEN
                MOV DX, OFFSET NUMBER_ARRAY
                CALL FIND_MIN
                
                MOV AH, 9
                MOV DX, OFFSET AVG_OUTPUT_STATEMENT
                INT 21H
                
                MOV AH, 2
                MOV DL, AVG_VAL
                ADD DL, '0'
                INT 21H
                
                MOV AH, 9
                MOV DX, OFFSET MAX_OUTPUT_STATEMENT
                INT 21H
                
                MOV AH, 2
                MOV DL, MAX_VAL
                ADD DL, '0'
                INT 21H
                
                MOV AH, 9
                MOV DX, OFFSET MIN_OUTPUT_STATEMENT
                INT 21H
                
                MOV AH, 2
                MOV DL, MIN_VAL
                ADD DL, '0'
                INT 21H
    
MAIN ENDP

RET

READ_NUMBER PROC
    
    READ_NUMBER_INIT: XOR BX, BX
    
                      MOV SI, DX
    
                      MOV AH, 1
    
    READ_NUMBER_LOOP: CMP BX, CX
                      JZ READ_NUMBER_END
               
                      INT 21H
    
                      CMP AL, 13
                      JZ READ_NUMBER_END
                      
                      SUB AL, '0'
               
                      MOV [SI], AL
               
                      INC SI
               
                      INC BX
               
                      JMP READ_NUMBER_LOOP
               
    READ_NUMBER_END: MOV AH, 2
              
                     MOV DX, 0DH
                     INT 21H
                     
                     MOV DX, 0AH
                     INT 21H
    
    RET
    
READ_NUMBER ENDP

FIND_AVG PROC
    
    FIND_AVG_INIT: MOV SI, DX
    
                   MOV BX, CX
    
                   XOR AX, AX
    
    FIND_AVG_LOOP: MOV AL, [SI]
                   
                   ADD AVG_VAL, AL
                   
                   INC SI
               
                   LOOP FIND_AVG_LOOP
               
    FIND_AVG_END: MOV AL, AVG_VAL
                   
                  DIV BL
                  
                  MOV AVG_VAL, AL
    
    RET
    
FIND_AVG ENDP

FIND_MAX PROC
    
    FIND_MAX_INIT: MOV SI, DX
    
                   MOV MAX_VAL, 0
    
    FIND_MAX_LOOP: MOV AL, [SI]
                   
                   CMP MAX_VAL, AL
                   JGE SKIP_WRITE_MAX
                   
                   MOV MAX_VAL, AL
                   
                   SKIP_WRITE_MAX: 
                   
                   INC SI
               
                   LOOP FIND_MAX_LOOP
               
    FIND_MAX_END: 
    
    RET
    
FIND_MAX ENDP

FIND_MIN PROC
    
    FIND_MIN_INIT: MOV SI, DX
    
                   MOV MIN_VAL, 9
    
    FIND_MIN_LOOP: MOV AL, [SI]
                   
                   CMP MIN_VAL, AL
                   JLE SKIP_WRITE_MIN
                   
                   MOV MIN_VAL, AL
                   
                   SKIP_WRITE_MIN: 
                   
                   INC SI
               
                   LOOP FIND_MIN_LOOP
               
    FIND_MIN_END: 
    
    RET
    
FIND_MIN ENDP