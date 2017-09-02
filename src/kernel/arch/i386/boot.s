# Declare constants for the multiboot header.
.set ALIGN,    1<<0
.set MEMINFO,  1<<1
.set FLAGS,    ALIGN | MEMINFO
.set MAGIC,    0x1BADB002
.set CHECKSUM, -(MAGIC + FLAGS)

.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

.section .bss
.align 16
stack_bottom:
.skip 65536 # 64 KiB
stack_top:


.section .text
.global _start
.type _start, @function
_start:
    sti
    mov $stack_top, %esp
    call kernel_bfmain
    cli
1:  hlt
    jmp 1b

.size _start, . - _start
