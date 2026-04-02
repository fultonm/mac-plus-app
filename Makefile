# Makefile for Macintosh Plus Bootable Disk

CC = gcc
AS = as68
LD = ld68

TARGETS = boot_sector.o system_init.o resource_fork.o

all: mac-plus.img

mac-plus.img: $(TARGETS)
	$(LD) -o mac-plus.elf $(TARGETS)

boot_sector.o: boot_sector.asm
	$(AS) -o boot_sector.o boot_sector.asm

system_init.o: system_init.asm
	$(AS) -o system_init.o system_init.asm

resource_fork.o: resource_fork.c
	$(CC) -c resource_fork.c -o resource_fork.o

clean:
	rm -f *.o *.elf mac-plus.img

.PHONY: all clean