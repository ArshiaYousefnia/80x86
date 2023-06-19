section .data
    scan_format: db "%d", 0
    print_format: db "result is:", 0xA,"%.16f", 0xA, 0
    
section .bss
    input: resb 4
    result: resb 8
    temporary: resb 4
    
section .text
global main
extern printf
extern scanf

main:        
    mov ebp, esp
    
    push input
    push scan_format
    call scanf
    add esp, 8
    
    mov ebx, [input]
    fldz
    
Lop:
    fld1
    mov [temporary], ebx
    fidiv dword [temporary]
    fidiv dword [temporary]
    faddp
    dec ebx
    jnz Lop
    
    fstp qword [result]
    push dword [result+4]  ;pushes 32 bits (MSB)
    push dword [result]    ;pushes 32 bits (LSB)
    push print_format
    call printf
    add esp, 12   
    ret
