assume cs:code

data segment
    db "Welcome to masm!", 0
data ends

code segment
start:
    mov dh, 10   ;行
    mov dl, 10   ;列
    mov cl, 2    ;绿色前景色
    mov ax, data ;data segment
    mov ds, ax   ;(ds) = data segment
    mov si, 0    ;si指向data segment字符串首地址

    int 7CH      ;调用7CH中断号的中断例程

    mov ax, 4C00H
    int 21H

code ends

end start