 extern io_print_dec

section .data
    i: dd 0
    j: dd 0

section .bss
    a resw 48
    p resd 1

section .text
    global main

    lol:
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]
    add eax, [ebp+12]
    pop ebp
    ret

    main:
    push 1
    push 2
    call lol
    call io_print_dec
    pop ebx
    pop ebx 
