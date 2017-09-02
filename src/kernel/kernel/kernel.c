//
// Prefix for bf2c code generation phase
// Provides kernel_bfmain function to be called
// by boot.s and declares the array the
// brainfuck code needs to function
//

#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif
 
#if !defined(__i386__)
#error "This needs to be compiled with a ix86-elf compiler"
#endif

#include "vga_driver.h"

void putchar(char c){
    vga_write(&c, 1);
}

void *memset(void *bufptr, int value, size_t size){
    unsigned char *buf = (unsigned char*)bufptr;
    for(size_t i = 0; i < size; i++){
        buf[i] = (unsigned char)value;
    }
    return bufptr;
}

void kernel_bfmain(void){
    vga_initialize();
    char array[30000] = {0};
    int dptr = 0;
    array[dptr] += 8;
    while(array[dptr]){
        dptr++;
        array[dptr] += 4;
        while(array[dptr]){
            dptr++;
            array[dptr] += 2;
            dptr++;
            array[dptr] += 3;
            dptr++;
            array[dptr] += 3;
            dptr++;
            array[dptr]++;
            dptr -= 4;
            array[dptr]--;
        }
        dptr++;
        array[dptr]++;
        dptr++;
        array[dptr]++;
        dptr++;
        array[dptr]--;
        dptr += 2;
        array[dptr]++;
        while(array[dptr]){
            dptr--;
        }
        dptr--;
        array[dptr]--;
    }
    dptr += 2;
    putchar(array[dptr]);
    dptr++;
    array[dptr] -= 3;
    putchar(array[dptr]);
    array[dptr] += 7;
    putchar(array[dptr]);
    putchar(array[dptr]);
    array[dptr] += 3;
    putchar(array[dptr]);
    dptr += 2;
    putchar(array[dptr]);
    dptr--;
    array[dptr]--;
    putchar(array[dptr]);
    dptr--;
    putchar(array[dptr]);
    array[dptr] += 3;
    putchar(array[dptr]);
    array[dptr] -= 6;
    putchar(array[dptr]);
    array[dptr] -= 8;
    putchar(array[dptr]);
    dptr += 2;
    array[dptr]++;
    putchar(array[dptr]);
    dptr++;
    array[dptr] += 2;
    putchar(array[dptr]);
    return;
}

//
// Postfix for the bf2c code generation phase
//
