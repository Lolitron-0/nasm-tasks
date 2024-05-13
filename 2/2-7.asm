extern io_get_dec, io_print_dec, io_print_char

section .bss
  array: resd 10001
  n: resd 1

section .text
  global main

  main:
    call io_get_dec
    mov dword[n], eax

    mov ecx, eax
    dec ecx; ecx = n-1
    .inp_loop:
      push ecx
      call io_get_dec
      pop ecx
      mov dword[array + 4*ecx], eax
      dec ecx
      jns .inp_loop
      
    mov ebx, 0
    .loop_i:
      mov ecx, 0
      ;inc ecx
      .loop_j:
        mov eax, dword[array + 4*ebx]; eax = array[i]
        cmp eax, dword[array + 4*ecx]; cmp with array[j]
        jge .loop_j_cnt
        ; swap
        mov edx, dword[array + 4*ecx]; edx = array[j]
        mov dword[array + 4*ecx], eax; array[j] = array[i]
        mov dword[array + 4*ebx], edx; array[i] = edx

        .loop_j_cnt:
        inc ecx
        cmp ecx, dword[n]
        jl .loop_j
      
      ; loop_i_cnt
      inc ebx
      cmp ebx, dword[n]
      jl .loop_i
    
    xor ecx, ecx
    .out_loop:
      mov eax, dword[array + 4*ecx]
      push ecx
      call io_print_dec
      mov eax, 32; space
      call io_print_char
      pop ecx
      inc ecx
      cmp ecx, dword[n]
      jl .out_loop
    
    xor eax, eax
    ret

    


        

        




