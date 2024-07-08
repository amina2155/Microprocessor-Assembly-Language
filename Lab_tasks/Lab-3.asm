org 100h

.DATA

EXTRAVAR DW 0

input_string DB 'We are IUT Students', 0Dh, 0Ah, '$'

.CODE

MAIN PROC

MOV AH, 9
LEA DX, input_string
INT 21h
mov SI, DX

count_loop:

MOV AL, [SI] 
CMP AL, '$'

JZ ended_loop

ADD EXTRAVAR, 1
INC SI  
loop count_loop  

ended_loop:

MOV AH, 2h
MOV DX, EXTRAVAR  
INT 21h

MAIN ENDP
END MAIN
RET

