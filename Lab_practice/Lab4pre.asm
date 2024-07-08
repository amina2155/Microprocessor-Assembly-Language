org 100h       

.DATA
 
A  db 1, 2, 3, 4, 5, 6, 7, 8 
BO  dw 00h  


message db 'Enter the value of N (Between 0 and 8) : $' 


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

cmp cl, 0
jz factzero

mov ax, 1
mov bh, 0

looping:
    mov bl, [si] 
    mul bx
    inc si
    loop looping     

mov BO, ax
mov bx, 10  
mov dx, 0
mov cx, 0


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

jmp endend
  
  
    
factzero:

mov AH, 2
mov DL, 0DH
INT 21H
mov DL, 0AH
INT 21H
mov dx, '1'    
INT 21h

endend:  

MAIN ENDP
END MAIN
RET