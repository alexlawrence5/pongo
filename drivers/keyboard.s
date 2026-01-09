org 0

dd -1
dw 8000h
dw strtgy
dw interrupt
db 'KBDHACK '

rhp_ptr     dw 0,0
old_int9    dw 0,0

strtgy:
    mov [rhp_ptr], bx
    mov [rhp_ptr+2], es
    retf

interrupt:
    push ax
    push bx
    push es
    push di

    les di, [rhp_ptr]
    mov al, es:[di+2]
    test al, al
    jz init_driver

finish:
    mov word es:[di+3], 0

    pop di
    pop es
    pop bx
    pop ax
    retf

init_driver:
    mov ax, 3509h
    int 21h
    mov [old_int9], bx
    mov [old_int9+2], es

    mov dx, keyboard_isr
    mov ax, 2509h
    int 21h

    mov word es:[di+0Eh], 1
    jmp finish

keyboard_isr:
    push ax

    in al, 60h
    cmp al, 1Eh
    jne forward
    mov al, 30h
    out 60h, al

forward:
    pop ax
    jmp far [old_int9]
