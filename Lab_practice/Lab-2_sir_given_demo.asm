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

; go to a new line with carriage return

MOV AH, 2
MOV DL, 0DH
INT 21h

MOV DL, 0AH
INT 21h 

; display character 

MOV DL, BL
INT 21h    

; return to DOS 

MOV AH, 4CH
INT 21H 

MAIN ENDP
END MAIN
RET





