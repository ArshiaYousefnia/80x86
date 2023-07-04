section .data
    array: db 'sdsfds4v-6ii 9oo-60 hjhjh88i77hj', 0
    array_len: equ $ - array
    result_print_format: db "---", 0xA, "chars:", 0xA, "%s", 0xA, "sum: %d", 0xA, "count: %d", 0xA, "average: %f", 0
    char_print_format: db "%c", 0
    number_print_format: db "%d", 0xA, 0
    is_negative: db 0
    
section .bss
    current_number: resb 4
    digits_count: resb 4
    sum: resb 4
    count: resb 4
    average: resb 8
    char_count: resb 4
    characters: resb 2000
section .text
    global main
    extern printf
    
main:
    mov ebp, esp; for correct debugging

    mov esi, array
    mov eax, 0
    mov ecx, array_len
    
    extract_numbers:
        cmp dword [count], 10 ; continue extraction until maximum of 10 numbers are extracted
        je finalize
        
        ; Load a byte from esi into al and increment esi
        lodsb
        
        ; check if this character is a digit
        cmp al, '0'
        jl not_a_number
        cmp al, '9'
        jg not_a_number

        ; Subtract ASCII value of '0' to convert to numeric value
        sub al, '0'
        
        ; insert this digit t the rest of digits of this number
        mov ebx, [current_number]
        imul ebx, 10
        mov [current_number], ebx
        add [current_number], al
        
        ; increment digits counter
        inc dword [digits_count]
        
        ; Decrement ecx to keep track of remaining characters
        dec ecx
        jnz extract_numbers
        
    ; hanlde the case in which character is not a digit
    not_a_number:
        ; increment number of characters
        mov ebx, characters
        add ebx, [char_count]
        mov [ebx], al
        inc dword [char_count]
        ; increment the numbers counter if last charachters were digits
        cmp dword [digits_count], 0
        jne increment_count
        
        continue:
        ; reset digits counter
        mov dword [digits_count], 0
        
        ; reset current number to continue
        mov dword [current_number], 0
        
        mov dword [is_negative], 0
        cmp al, '-'
        jne checkpoint1
        mov dword [is_negative], 1
        
        checkpoint1:
        ; Decrement ecx to keep track of remaining characters
        dec ecx
        jnz extract_numbers  
        
    finalize:
    ;end characters string
    mov ebx, characters
    add ebx, [char_count]
    mov dword [ebx], 0
    
    ; calculate the average
    fild dword [sum]
    fidiv dword [count]
    fstp qword [average]
    
    
    ; print the results to the console
    push dword [average+4]  ;pushes 32 bits (MSB)
    push dword [average]    ;pushes 32 bits (LSB)
    push dword [count]
    push dword [sum]
    push characters
    push result_print_format
    call printf
    add esp, 24
       
    ret
    
    increment_count:
        inc dword [count]
        
        ;check sign      
        cmp dword [is_negative], 1
        jne next
        not dword [current_number]
        add dword [current_number], 1
        
        next:
        ; add current number to rest of the numbers up to now
        mov ebx, [current_number]
        add ebx, [sum]
        mov [sum], ebx
        
        ; print current number to console
        push eax
        push ecx
        push dword [current_number]
        push number_print_format
        call printf
        add esp, 8
        pop ecx
        pop eax
        
        jmp continue