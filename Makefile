DEFAULT_HOST != ./default-host.sh
HOST ?= DEFAULT_HOST
HOSTARCH != ./target-triplet-to-arch.sh $(HOST)

CFLAGS ?= -ffreestanding -Wall -Wextra -O2 -g
LDFLAGS ?= 
LIBS ?= -nostdlib -lk -lgcc

DESTDIR ?=
PREFIX ?= /usr/local
EXEC_PREFIX?= $(PREFIX)
BOOTDIR ?= $(EXEC_PREFIX)/boot
INCLUDEDIR ?= $(PREFIX)/include

ARCHDIR = arch/$(HOSTARCH)

include $(ARCHDIR)/make.config

CFLAGS := $(CFLAGS) $(KERNEL_ARCH_CFLAGS)
LDFLAGS := $(LDFLAGS) $(KERNEL_ARCH_LDFLAGS)
LIBS := $(LIBS) $(KERNEL_ARCH_LIBS)

KERNEL_OBJS= $(KERNEL_ARCH_OBJS) kernel/kernel.o

OBJS= $(ARCHDIR)/io.o $(KERNEL_OBJS)

LINK_LIST = $(LDFLAGS) $(KERNEL_OBJS) $(LIBS) $(ARCHDIR)/io.o


.PHONY: all clean install install-headers install-kernel
.SUFFIXES: .o .c .s

all: bfbgen.kernel

bfbgen.kernel: $(OBJS) $(ARCHDIR)/linker.ld
	$(CC) -T $(ARCHDIR)/linker.ld -o $@ $(CFLAGS) $(LINK_LIST)
	grub-file --is-x86-multiboot bfbgen.kernel

.c.o:
	$(CC) -MD -c $< -o $@ -std=gnu11 $(CFLAGS)

.s.o:
	$(CC) -MD -c $< -o $@ $(CFLAGS)

clean:
	rm -f bfbgen.kernel
	rm -f $(OBJS) *.o */*.o */*/*.o
	rm -f $(OBJS:.o=.d) *.d */*.d */*/*.d

instal: install-headers install-kernel

install-kernel: bfbgen.kernel
	mkdir -p $(DESTDIR)$(BOOTDIR)
	cp bfbgen.kernel $(DESTDIR)$(BOOTDIR)

-include $(OBJS:.o=.d)
