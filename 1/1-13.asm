extern io_get_char, io_print_char, io_print_dec;

section .bss;
    startX: resb 1;
    startY: resb 1;
    diffX: resb 1;

section .text;
    global main;

    main:
        call io_get_char;
        mov byte[startX], al;

        call io_get_char;
        mov byte[startY], al;

        call io_get_char; skip space

        call io_get_char;
        sub al, byte[startX]; al = +-diffX
        ; abs
        mov bl, al;
        sar bl, 31; 
        xor al, bl;
        sub al, bl;
        ;
        mov byte[diffX], al;

        call io_get_char;
        sub al, byte[startY]; al = +-diffY
        ; abs
        mov bl, al;
        sar bl, 31; 
        xor al, bl;
        sub al, bl;
        ;

        add al, byte[diffX];
        call io_print_dec;

        xor eax, eax;
        ret