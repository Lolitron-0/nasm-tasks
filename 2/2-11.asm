extern  io_get_udec, io_print_udec

section .bss
  num1 resd 1
  num2 resd 1

section .text
  global main

  main:
    call io_get_udec
    mov dword[num1], eax
    call io_get_udec
    mov dword[num2], eax
    
    .loop:
      cmp dword[num1], 0 
      je .print_num2
      cmp dword[num2], 0 
      je .print_num1
      
      mov eax, dword[num1]
      cmp eax, dword[num2]
      jb .first_less; if(num1 < num2)
      cdq
      div dword[num2]
      mov dword[num1], edx; num1 %= num2
      jmp .loop

      .first_less:  
        mov eax, dword[num2]
        cdq
        div dword[num1] 
        mov dword[num2], edx; num2 %= num1
        jmp .loop

    .print_num1:
      mov eax, dword[num1]
      call io_print_udec
      jmp .end
    .print_num2:
      mov eax, dword[num2]
      call io_print_udec
      jmp .end

    .end:
      xor eax, eax
      ret