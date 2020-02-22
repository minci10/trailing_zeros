section .bss
c: resb 1 ; character buffer
result resb 3
section .data
factorial dq 8735373
section .text
_dprint:
    pushad        
    add eax, '0' 
    mov [c], eax  
    mov eax, 0x04 
    mov ebx, 1   
    mov ecx, c    
    mov edx, 1    
    int 0x80     
    popad       
    ret          
; writes an integer number stored in eax in decimal at stdout
_iprint:
    mov ebx, 10 
    mov ecx, 1 
Cycle1:
    mov edx, 0  
  
    div ebx     
    
    push edx    ; digits we have to write are in reverse order
    cmp eax, 0 
    jz EndLoop1 
    inc ecx     
    jmp Cycle1  
EndLoop1:
; write the integer digits by poping them out from the stack
Cycle2:
    pop eax     
    call _dprint 
    dec ecx     
    jz EndLoop2  
    jmp Cycle2   
EndLoop2:   
    popad 
    ret   

global _start      
	
_start:	               

loop:

    mov edx, 0
    mov eax,[factorial]
    mov ecx,5
    div ecx
    add [result],eax
    mov [factorial],eax
    cmp eax,5
    jge loop
    mov eax, [result] 
    call _iprint   
    mov eax, 0x01 
    mov ebx, 0    
    int 0x80      
