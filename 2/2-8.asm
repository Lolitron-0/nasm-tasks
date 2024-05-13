extern io_get_dec, io_print_dec, io_print_char

section .bss
  n resd 1
  m resd 1
  k resd 1
  mat1 resd 10202 ; 101 * 101 + 1
  mat2 resd 10202
  result resd 10202
  i resd 1
  j resd 1
  t resd 1

section .text
  global main

  main:
    call io_get_dec
    mov dword[n], eax
    call io_get_dec
    mov dword[m], eax
    call io_get_dec
    mov dword[k], eax

    ; mat1
    xor ecx, ecx
    mov ebx, dword[n]
    imul ebx, dword[m]
    .inp_loop1:
      push ecx
      call io_get_dec
      pop ecx
      mov dword[mat1 + 4*ecx], eax

      inc ecx
      cmp ecx, ebx
      jl .inp_loop1
    
    ; mat2
    xor ecx, ecx
    mov ebx, dword[m]
    imul ebx, dword[k]
    .inp_loop2:
      push ecx
      call io_get_dec
      pop ecx
      mov dword[mat2 + 4*ecx], eax

      inc ecx
      cmp ecx, ebx
      jl .inp_loop2

    .loop_i:
        mov dword[j], 0
      .loop_j:
        xor eax, eax
        mov dword[t], 0
        .loop_t:
          mov ecx, dword[i]
          imul ecx, dword[m]
          add ecx, dword[t] 
          mov esi, dword[mat1 + 4*ecx] ; esi = mat1[i][t]

          mov ecx, dword[t]
          imul ecx, dword[k]
          add ecx, dword[j] 
          mov edi, dword[mat2 + 4*ecx] ; edi = mat2[t][j]

          imul esi, edi
          add eax, esi

          inc dword[t]
          mov edx, dword[m]
          cmp dword[t], edx
          jl .loop_t
        
        
        mov ecx, dword[i]
        imul ecx, dword[k]
        add ecx, dword[j]
        call io_print_dec
        push eax
        push ecx
        mov eax, 32
        call io_print_char
        pop ecx
        pop eax
        mov dword[result+4*ecx], eax; result[i][j] = eax

        inc dword[j]
        mov edx, dword[k]
        cmp dword[j], edx
        jl .loop_j

      mov eax, 10
      call io_print_char
      inc dword[i]
      mov edx, dword[n]
      cmp dword[i], edx
      jl .loop_i
      