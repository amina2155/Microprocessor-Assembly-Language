ORG 0100h
    
.DATA    
EXTRAVAR DB ? 


.CODE  

MAIN PROC 

MOV AH, 2
MOV DL, '?'
INT 21h

JMP TAKE_INPUT

INVALID_INPUT:
              MOV AH, 2
              MOV DL, 08H  
              INT 21H 
              MOV DL, 20H
              INT 21H
              MOV DL, 08H  
              INT 21H 
              

TAKE_INPUT: 
            MOV AH, 1
            INT 21h
            MOV BL, AL
            MOV EXTRAVAR, BL
             
            CMP BL, 41H
            JL  INVALID_INPUT
            
            CMP BL, 7AH
            JG  INVALID_INPUT
            
            CMP BL, 5AH
            JLE PROCESS_TO_SMALLER
            
            CMP BL, 61H
            JGE PROCESS_TO_CAPITAL
            
            JMP INVALID_INPUT
             



PROCESS_TO_SMALLER:
                   MOV AH, 2
                   MOV DL, 0DH
                   INT 21h
                   MOV DL, 0AH
                   INT 21h
                   
                   MOV CL, 5
 
                   ADD BL, 32
                   
                   JMP PRINT_SMALLER  
                   
                   
PROCESS_TO_CAPITAL:
                   MOV AH, 2
                   MOV DL, 0DH
                   INT 21h
                   MOV DL, 0AH
                   INT 21h
                   
                   MOV CL, 5
                   
                   SUB BL, 32
                   
                   JMP PRINT_CAPITAL
                    
                  

PRINT_CAPITAL: 
              ADD BL, 1
              
              CMP BL, 5AH
              JG  WRAP_CAPITAL 
              
              MOV DL, BL
              INT 21h
              SUB CL, 1
              
              CMP CL, 0
              JZ  PRINT_PREVIOUS_CAPITAL_PROCESS
              
              JMP PRINT_CAPITAL 
              


PRINT_SMALLER:
              ADD BL, 1
              
              CMP BL, 7AH
              JG  WRAP_SMALLER
              
              MOV DL, BL
              INT 21h
              SUB CL, 1
              
              CMP CL, 0
              JZ PRINT_PREVIOUS_SMALLER_PROCESS
              
              JMP PRINT_SMALLER 
              
              
              
              
PRINT_PREVIOUS_CAPITAL_PROCESS:
                                MOV AH, 2
                                MOV DL, 0DH
                                INT 21h
                                MOV DL, 0AH
                                INT 21h
                                
                                MOV CL, 5
                                MOV BL, EXTRAVAR
                                SUB BL, 32 
                                
                                
                                JMP PRINT_PREVIOUS_CAPITAL


PRINT_PREVIOUS_SMALLER_PROCESS:
                                MOV AH, 2
                                MOV DL, 0DH
                                INT 21h
                                MOV DL, 0AH
                                INT 21h
                                
                                MOV CL, 5
                                MOV BL, EXTRAVAR
                                ADD BL, 32 
                                
                                
                                JMP PRINT_PREVIOUS_SMALLER


PRINT_PREVIOUS_CAPITAL:
                SUB BL, 1 
                
                CMP BL, 41H
                JL  WRAP_PREV_CAPITAL
                
                MOV DL, BL
                INT 21h
                SUB CL, 1
              
                CMP CL, 0
                JZ FINISH
              
                JMP PRINT_PREVIOUS_CAPITAL 


PRINT_PREVIOUS_SMALLER:
                SUB BL, 1
                
                CMP BL, 61H
                JL WRAP_PREV_SMALLER
                
                MOV DL, BL
                INT 21h
                SUB CL, 1
              
                CMP CL, 0
                JZ FINISH
              
                JMP PRINT_PREVIOUS_SMALLER

WRAP_CAPITAL:
             SUB BL, 1BH
             JMP PRINT_CAPITAL


WRAP_SMALLER:
             SUB BL, 1BH
             JMP PRINT_SMALLER
             
             
WRAP_PREV_CAPITAL:
                  ADD BL, 1BH
                  JMP PRINT_PREVIOUS_CAPITAL
                  
WRAP_PREV_SMALLER:    
                  ADD BL, 1BH
                  JMP PRINT_PREVIOUS_SMALLER

FINISH:

MAIN ENDP
END MAIN
RET