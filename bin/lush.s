bits 16
org 0x0000

%include "sdk/osle.inc"

start:
    call cls

main_loop:
    mov si, PROMPT
    mov cx, 0xFFFF
    call str_print

    call read_line

    mov si, CMD_BUFFER

    mov di, CMD_EXIT
    call strcmp
    je shell_exit

    mov di, CMD_HELP
    call strcmp
    je shell_help

    mov di, CMD_CL
    call strcmp
    je shell_cl

    mov si, UNKNOWN
    mov cx, 0xFFFF
    call str_print
    jmp main_loop

shell_help:
    mov si, HELP_TXT
    mov cx, 0xFFFF
    call str_print
    jmp main_loop

shell_cl:
    call cls
    jmp main_loop

shell_exit:
    int INT_RETURN

cls:
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    ret

read_line:
    pusha
    mov di, CMD_BUFFER
.read:
    xor ax, ax
    int 0x16
    cmp al, 0x0D
    je .done
    mov ah, 0x0E
    int 0x10
    mov [di], al
    inc di
    jmp .read
.done:
    mov byte [di], 0
    mov ah, 0x0E
    mov al, 0x0A
    int 0x10
    mov al, 0x0D
    int 0x10
    popa
    ret

str_print:
    pusha
    mov ah, 0x0E
.loop:
    lodsb
    test al, al
    jz .done
    int 0x10
    loop .loop
.done:
    popa
    ret

strcmp:
    push si
    push di
.loop:
    mov al, [si]
    mov bl, [di]
    cmp al, bl
    jne .no
    test al, al
    jz .yes
    inc si
    inc di
    jmp .loop
.yes:
    pop di
    pop si
    xor ax, ax
    ret
.no:
    pop di
    pop si
    mov ax, 1
    ret

PROMPT     db "pongo> ", 0
UNKNOWN    db "lush: command not found!", 0x0A, 0x0D, 0

HELP_TXT:
    db 0x0A, 0x0D
    db "Builtins:", 0x0A, 0x0D
    db "  help", 0x0A, 0x0D
    db "  cl", 0x0A, 0x0D
    db "  exit", 0x0A, 0x0D
    db 0

CMD_BUFFER times 64 db 0

CMD_EXIT db "exit", 0
CMD_HELP db "help", 0
CMD_CL   db "cl", 0
