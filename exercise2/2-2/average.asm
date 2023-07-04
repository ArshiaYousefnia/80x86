global _average
section .text

_average:
    mov ebp, esp
    mov eax, [ebp + 4] ;load pointer to array
    mov ecx, [ebp + 8] ;load count
    
    ;compute the sum
    fldz
    
    cmp ecx, 0
    je end
    
    fiadd dword [eax]
    dec ecx
    jz end
    loop_start:
      fiadd dword [eax + 4 * ecx]
      loop loop_start
    
    fidiv dword [ebp + 8] ;divide by count
end:
    ret