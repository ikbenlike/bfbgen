.global outb

outb:
    mov 8(%esp), %al #, [esp + 8]    
    mov 4(%esp), %dx #, [esp + 4]    
    out %al, %dx #, %al
    ret

.global inb

inb:
    mov 4(%esp), %dx #, [esp + 4]       ; move the address of the I/O port to the dx register
    in  %dx, %al #, %dx #               ; read a byte from the I/O port and store it in the al register
    ret         #                       ; return the read byte
