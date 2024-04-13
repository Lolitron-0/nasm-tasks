extern io_get_dec, io_print_dec;

section .bss;
    month: resd 1;
    day: resd 1;

section .text;
    global main;

    main:

        call io_get_dec;
        sub eax, 1;
        mov dword[month], eax;

        call io_get_dec;
        mov dword[day], eax;

        mov eax, dword[month];
        cdq
        mov ecx, 2;
        div ecx; edx - remainder, eax - months with 42

        xor ecx, ecx;
        imul ecx, eax, 42
        add dword[day], ecx;

        xor ecx, ecx;
        add eax, edx; al = months with 41
        imul ecx, eax, 41
        add dword[day], ecx;

        mov eax, dword[day];
        call io_print_dec;

        xor eax, eax;
        ret