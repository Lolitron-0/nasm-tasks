extern io_get_udec, io_print_udec

section .text
    global main
    
    main:
       call io_get_udec 
       
       mov ebx, 0
       .loop:
            mov ecx, eax
            and ecx, 0x1
            add ebx, ecx
            shr eax, 1;

            test eax, eax 
            jnz .loop
        
        mov eax, ebx
        call io_print_udec


