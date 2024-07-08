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
mov dx, OFFSET message
   
;Print message
mov ah, 09h 
int 21h

;Take N as input and convert it to ascii of decimal N
 
mov ah, 01h
int 21h
mov cl, al
sub cl, 48
 
xor ax, ax 

Loop_1:
    mov ax, [si]
    mov ah, 0
    mul [si] 
    add BO, ax
    inc si
    loop Loop_1     


mov bx, 10  
mov dx, 0
mov cx, 0
xor ax, ax
mov  ax, BO

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

print:
    pop dx   
    add dx, 48    
    int 21h
    loop print


MAIN ENDP
END MAIN
RET