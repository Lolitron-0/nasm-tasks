extern io_get_udec, io_print_udec

section .bss
  n resd 1
  needed_zeroes resd 1
  len resd 1
  result resd 1
  comb resd 1025 ; 32 * 32 + 1
  i resd 1
  j resd 1
  num_zeroes_local resd 1

section .text
  global main
  
  main:
    call io_get_udec
    mov dword[n], eax
    call io_get_udec
    mov dword[needed_zeroes], eax

    cmp dword[needed_zeroes], 32
    jg .print

    .comb_loop_i:
      
      mov dword[j], 0
      .comb_loop_j:
        mov ecx, dword[i]       
        imul ecx, 32
        add ecx, dword[j]
        mov dword[comb + 4*ecx], 0

        cmp dword[j], 0
        je .diag
        mov eax, dword[i]
        cmp dword[j], eax
        je .diag
        jmp .not_diag
        
        .diag: ; j == 0 || j == i
        mov dword[comb + 4*ecx], 1
        jmp .fi
        .not_diag: ; else
        mov ecx, dword[i]
        dec ecx
        imul ecx, 32
        add ecx, dword[j]
        mov eax, dword[comb + 4*ecx - 4]
        add eax, dword[comb + 4*ecx ]
        mov dword[comb+4*ecx + 32*4], eax ; comb[i][j] = comb[i-1][j] + comb[i-1][j-1]
        .fi: ; end

        inc dword[j]
        mov eax, dword[i]
        cmp dword[j], eax
        jle .comb_loop_j

      inc dword[i]
      cmp dword[i], 32
      jl .comb_loop_i

    mov eax, dword[n]
    xor ecx, ecx
    .count_digits_loop:
      inc ecx
      shr eax, 1
      jnz .count_digits_loop
    
    mov dword[len], ecx
    mov ecx, dword[needed_zeroes]
    inc ecx
    cmp ecx, dword[len]
    jae .end_shorter_loop ; if ecx >= num_len
    .shorter_loop:
      mov ebx, ecx    
      dec ebx
      imul ebx, 32
      add ebx, dword[needed_zeroes]
      mov eax, dword[comb + 4*ebx]
      add dword[result], eax; result += comb[i-1][k]

      inc ecx
      cmp ecx, dword[len]
      jl .shorter_loop ; if ecx < num_len
    .end_shorter_loop:
    
    mov ecx, dword[len]
    sub ecx, 2
    cmp ecx, 0
    jl .end_len_loop
    .len_loop:
      mov eax, dword[n]
      shr eax, cl
      and eax, 1 ; ecx-th bit
      
      jz .not_1
      
        mov ebx, dword[needed_zeroes]
        dec ebx
        sub ebx, dword[num_zeroes_local] ; ebx = num_zeroes - 1 - num_zeroes_local
        cmp ebx, 0
        jl .endif  ; if num_zeroes - 1 - num_zeroes_local >= 0 then

            mov edx, ecx;
            imul edx, 32;
            add edx, ebx
            mov edx, dword[comb + 4*edx]
            add dword[result], edx; result += comb[i][ebx]

        jmp .endif

      .not_1:
        inc dword[num_zeroes_local]

      .endif:    
    
      dec ecx
      cmp ecx, 0
      jge .len_loop ;  if ecx > 0 

    .end_len_loop:
    mov ecx, dword[num_zeroes_local]
    cmp ecx, dword[needed_zeroes]
    jne .print
    inc dword[result]
    .print:

    mov eax, dword[result]
    call io_print_udec
    xor eax, eax
    ret
