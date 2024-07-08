org 100h
.data
arr db 5 dup(?) 

input_array db 'Input:$'
input_num db 'Input Search Item:$' 
outputfrst db 'Digit $' 
outputlst db ' Found $'
outputlst2 db ' Not Found $'
n db ? 

.code

main proc
    
        mov ah,9
        lea dx,input_array 
        int 21h
        
        mov cx,5 
        lea bx, arr
   
        
        input: 
            mov ah,1
            int 21h
            mov [bx],al
            inc bx
            
            mov ah, 02 ; printing the space
            mov dx,20h 
            int 21h
            
            loop input
            
        mov ah, 2
        mov dl, 0Ah 
        int 21h
        mov dl, 0Dh 
        int 21h   
           
        mov ah,9
        lea dx,input_num 
        int 21h
        
        mov ah,01h
        int 21h
        mov n, al        
        
        mov cx,5
        
        mov bx,0
        mov si,0
        
        outerloop:
            mov al,arr[si]
            cmp al,n
            jz go  
    
            inc si
            inc bx
            loop outerloop
            
            
        cmp bx, 5
        jz notfound
        
        go:
        
            mov ah, 2
            mov dl, 0Ah 
            int 21h
            mov dl, 0Dh 
            int 21h
                    
            mov ah,9
            lea dx,outputfrst 
            int 21h 
            
            mov ah, 02 ; printing the char
            mov dl, n
            int 21h
        
            mov ah,9
            lea dx,outputlst 
            int 21h
            
            jmp exit        
        
        
        notfound:
        
            mov ah, 2
            mov dl, 0Ah 
            int 21h
            mov dl, 0Dh 
            int 21h
        
            mov ah,9
            lea dx,outputfrst 
            int 21h 
            
            mov ah, 02 ; printing the char
            mov dl, n
            int 21h
        
            mov ah,9
            lea dx,outputlst2 
            int 21h
            
        exit:            
     
        
main endp
ret