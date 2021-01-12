assume cs:code

code segment

start:
    mov ax, cs
    mov ds, ax
    mov si, offset do0

    mov ax, 0
    mov es, ax
    mov di, 200H

    mov cx, offset do0end - offset do0

    cld
    rep movsb

    mov ax, 0
    mov es, ax
    mov word ptr es:[0], 200H
    mov word ptr es:[2], 0

    mov ax, 4C00H
    int 21H
do0:
    jmp short do0start
    db "devide error!"

do0start:
    mov ax, cs
    mov ds, ax
    mov si, 202H

    mov ax, 0b800H
    mov es, ax
    mov di, 12*160 + 36*2
    mov cx, 13

s:
    mov al, [si]
    mov es:[di], al
    mov byte ptr es:[di+1], 4
    inc si
    add di, 2
    loop s

    mov ax, 4C00H
    int 21H

do0end:
    nop

code ends

end start