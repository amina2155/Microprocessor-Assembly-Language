


ORG 0100h ; Offset of the program in memory
.DATA ; Data Segment Starts 

Cel DW 260 ; Variable B got a WORD value 500 
Far DW 0;

SUM DW ? ; Variable SUM is defined as a WORD variable without any value
DIFFERENCE DB ? ; Variable DIFFERENCE is defined as a WORD variable without any value
MULTIPLICATION DW ?
DIVISION DB ? 

.CODE ; Code Segment Starts

MAIN PROC ; Initialize Data Segment Register 
    
    mov AX, 10
    mov BX, 5
    div BX
    mul Cel
    add AX, 32
    sub AX, 1
    mov Far, AX
     
MAIN ENDP ; End Procedure
END MAIN ; End MAIN 

RET ; Return to DOS






