section .bss
align 16
ramdisk:
    resb 512*16

section .data
header: 
    dd -1
    dw 0x2000
    dw strategy
    dw interrupt
    db 1
    times 7 db 0
request: 
    dd 0

bpb: 
    dw 512
    db 1

section .text
global strategy
global interrupt

strategy:
    push ax
    push bx
    push cx
    push dx

    cmp ax, 0
    je read_sector
    cmp ax, 1
    je write_sector
    jmp done

read_sector:
    mov si, dx
    mov di, bx
    mov cx, cx
.read_loop:
    mov bx, di
    shl bx, 9
    mov di, bx
    mov si, dx
    mov cx, 512
    rep movsb
    add di, 512
    add dx, 512
    loop .read_loop
    jmp done

write_sector:
    mov si, dx
    mov di, bx
    mov cx, cx
.write_loop:
    mov bx, di
    shl bx, 9
    mov di, bx
    mov si, dx
    mov cx, 512
    rep movsb
    add di, 512
    add dx, 512
    loop .write_loop
    jmp done

done:
    pop dx
    pop cx
    pop bx
    pop ax
    ret

interrupt:
    ret
