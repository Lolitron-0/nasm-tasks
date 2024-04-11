extern io_get_dec, io_print_dec

section .text
    global main;

    main:
    call io_get_dec;
    mov ebx, eax;

    sar ebx, 31; ebx = mask

    xor eax, ebx;
    sub eax, ebx;

    call io_print_dec;

    xor eax, eax;
    ret;