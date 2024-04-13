extern io_get_udec, io_print_udec, io_print_char

section .bss
    a11: resd 1;
    a12: resd 1;
    a21: resd 1;
    a22: resd 1;
    b1: resd 1;
    b2: resd 1;

    not_row110: resd 1;
    not_row111: resd 1;

    x_one: resd 1;
    y_one: resd 1;

    x: resd 1;
    y: resd 1;


;   a1  a2  b   x   y
;   0   0   0   1   1  any
;   0   0   1   -   - 
;   0   1   0   1   0  y = b
;   0   1   1   1   1  y = b
;   1   0   0   0   1  x = 0
;   1   0   1   1   1  y any
;   1   1   0   1   1  x = y
;   1   1   1   1   0  x = ~y
section .text
    global main
    main:
        ; input
        call io_get_udec;
        mov dword[a11], eax;
        call io_get_udec;
        mov dword[a12], eax;
        call io_get_udec;
        mov dword[a21], eax;
        call io_get_udec;
        mov dword[a22], eax;
        call io_get_udec;
        mov dword[b1], eax;
        call io_get_udec;
        mov dword[b2], eax;

        ; x_zero
        mov eax, dword[a11]; a11
        mov ebx, dword[a12]; ~a12
        not ebx;
        and eax, ebx;
        mov ebx, dword[b1]; ~b1
        not ebx;
        and eax, ebx;

        mov ebx, dword[a21]; a21
        mov ecx, dword[a22]; ~a22
        not ecx;
        and ebx, ecx;
        mov ecx, dword[b2]; ~b1
        not ecx;
        and ebx, ecx;

        or eax, ebx; 
        not eax; 
        mov dword[x_one], eax; x_zero = (a11 and (not a12) and (not b1)) or (a21 and (not a22) and (not b2))

        ; y_zero
        mov eax, dword[a11]; ~a11
        not eax
        mov ebx, dword[b1]; ~b1
        not ebx;
        and eax, ebx;
        and eax, dword[a12];

        mov ebx, dword[a21]; ~a21
        not ebx
        mov ecx, dword[b2]; ~b2
        not ecx;
        and ebx, ecx;
        and ebx, dword[a22];

        or eax, ebx; 
        not eax; 
        mov dword[y_one], eax; y_zero = ((not a11) and a12 and (not b1)) or ((not a21) and a22 and (not b2))

        ; row110
        mov eax, dword[b1];
        not eax;
        and eax, dword[a11];
        and eax, dword[a12];

        mov ebx, dword[b2];
        not ebx;
        and ebx, dword[a21];
        and ebx, dword[a22];

        or eax, ebx;
        not eax;
        mov dword[not_row110], eax; row110 = (a11 and a12 and (not b1)) or (a21 and a22 and (not b2))

        ; row111
        mov eax, dword[a11];
        and eax, dword[a12];
        and eax, dword[b1];
 
        mov ebx, dword[a21];
        and ebx, dword[a22];
        and ebx, dword[b2];

        or eax, ebx;
        not eax;
        mov dword[not_row111], eax; row111 = (a11 and a12 and b1) or (a21 and a22 and b2)

        ; x
        mov ecx, dword[a11];
        and ecx, dword[a21]; ecx = (a11 and a21)

        mov eax, ecx;        
        or eax, dword[not_row110];
        or eax, dword[b1];
        or eax, dword[b2];

        mov ebx, dword[b1];
        and ebx, dword[b2];
        not ebx;
        or ebx, ecx;
        or ebx, dword[not_row111];

        and eax, dword[x_one];
        and eax, ebx;
        mov dword[x], eax; x = (not x_zero) and ((not row110) or (a11 and a21) or (b1 or b2)) and ((not row111) or (a11 and a21) or not (b1 and b2))

        ; y
        mov eax, dword[not_row110];
        or eax, dword[x];

        mov ebx, dword[x];
        not ebx;
        or ebx, dword[not_row111];

        and eax, ebx;
        and eax, dword[y_one];
        mov dword[y], eax; y = (not y_zero) and ((not row110) or x) and (not row111 or not x)

        ; output
        mov eax, dword[x];
        call io_print_udec;

        mov eax, 32; space
        call io_print_char;

        mov eax, dword[y];
        call io_print_udec;
 

        xor eax, eax
        ret