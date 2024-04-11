extern io_get_udec, io_print_udec;

section .text
global main
main: 
    call io_get_udec;
    push eax;

    call io_get_udec;
    neg eax;
    add eax, 32;
    xor ecx, ecx;
    mov cl, al;
    pop ebx;
    shl ebx, cl;
    shr ebx, cl;
    
    mov eax, ebx;
    call io_print_udec;
    xor eax, eax;
    ret
