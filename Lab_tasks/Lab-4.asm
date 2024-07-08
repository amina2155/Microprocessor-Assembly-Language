org 100h


.DATA
 
A  db 1, 2, 3, 4, 5, 6, 7, 8, 9 
BO  dw 00h  


message db 'Enter the value of N (Between 2 and 9) : $' 


.CODE
 
MAIN PROC
mov ax, @DATA
mov ds, ax 

xor ax,ax

mov si, OFFSET A
mov di, OFFSET BO
lea dx, message
   

mov ah, 09h 
int 21h

 
mov ah, 01h
int 21h
mov cl, al
sub cl, 48
 
xor ax, ax 

Loop_1:
    mov ax, [si]
    mul [si]
    add BO, ax
    inc si
    loop Loop_1
    
    
mov ax, BO
mov bx, 16
xor cx, cx


convert:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jnz convert
    
mov AH, 2
mov DL, 0DH
INT 21H
mov DL, 0AH
INT 21H
    
printprint:
    pop dx
    cmp dx, 9
    jl print0to9
    jmp printrest
    
    printAndLoop:
        int 21h
        loop printprint
        
    jmp exit

print0to9:
    add dx, 48
    jmp printAndLoop
    
printrest:
    sub dx, 10
    add dx, 'A'
    jmp printAndLoop

    exit:

MAIN ENDP
END MAIN
RET