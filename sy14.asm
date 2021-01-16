assume cs:code

code segment
start:

    mov dl, 9
    mov cx, 3

    mov bx, 0B800H
    mov es, bx
    mov di, 160 * 12 + 40 * 2
year_month_day:
    push cx

    mov al, dl
    out 70H, al
    in al, 71H

    mov ah, al
    mov cl, 4
    shr ah, cl
    and al, 00001111B

    add ah, 30H
    add al, 30H

    mov byte ptr es:[di], ah
    mov byte ptr es:[di + 1], 2
    mov byte ptr es:[di + 2], al
    mov byte ptr es:[di + 2 + 1], 2

    cmp dl, 7
    je not_do1

    mov byte ptr es:[di + 4], '/'
    mov byte ptr es:[di + 4 + 1], 2

not_do1:
    nop

    dec dl
    add di, 6

    pop cx
    loop year_month_day

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    mov dl, 4
    mov cx, 3

    mov bx, 0B800H
    mov es, bx
    mov di, 160 * 12 + 49 * 2
hour_min_sec:
    push cx

    mov al, dl
    out 70H, al
    in al, 71H

    mov ah, al
    mov cl, 4
    shr ah, cl
    and al, 00001111B

    add ah, 30H
    add al, 30H

    mov byte ptr es:[di], ah
    mov byte ptr es:[di + 1], 2
    mov byte ptr es:[di + 2], al
    mov byte ptr es:[di + 2 + 1], 2

    cmp dl, 0
    je not_do2

    mov byte ptr es:[di + 4], ':'
    mov byte ptr es:[di + 4 + 1], 2

not_do2:
    nop

    sub dl, 2
    add di, 6

    pop cx
    loop hour_min_sec

    mov ax, 4C00H
    int 21H

code ends
end start