ORG 0100h
MAIN PROC
; display prompt 

MOV AH, 2
MOV DL, '?'
INT 21h  

; input a character
MOV AH, 1
INT 21h
MOV BL, AL
cmp BL,96;
jg label_jg

jl label_jl

label_jg:
    mov AH, 2
    mov DL, 0DH
    INT 21H
    mov DL, 0AH
    INT 21H 
    SUB BL, 32
    MOV DL, BL
    INT 21h 
    RET
    
label_jl:
    mov AH, 2
    mov DL, 0DH
    INT 21H
    mov DL, 0AH
    INT 21H 
    ADD BL, 32
    MOV DL, BL
    INT 21h 
    
; return to DOS
MOV AH, 4CH
INT 21H  

MAIN ENDP
END MAIN
RET