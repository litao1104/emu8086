assume cs:code

code segment

start:
;1.安装中断，将do_7ch拷贝到0000:0200
    mov ax, cs
    mov ds, ax
    mov si, offset do_7ch

    mov ax, 0
    mov es, ax
    mov di, 200H

    mov cx, offset do_7ch_end - offset do_7ch

    cld
    rep movsb

;2.设置中断向量表，设置7ch中断类型码对应的中断程序(中断例程)入口地址
    mov ax, 0
    mov es, ax
    mov word ptr es:[7CH * 4], 200H
    mov word ptr es:[7CH * 4 + 2], 0

    mov ax, 4C00H
    int 21H

do_7ch:
lp:
    push bp
    mov bp, sp
    dec cx
    jcxz lpret
    add [bp + 2], bx ;此时栈顶是bp原来的数值，所以用+2
lpret:
    pop bp
    iret

do_7ch_end:
    nop

code ends

end start