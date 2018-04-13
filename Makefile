OS_NAME=AltaLang
PREFIX=~/opt/cross
TARGET=i686-elf
GCC_OPTS=-I $(PREFIX)/$(TARGET)/include

.PHONY: third_party lib

all: lib link

lib:
	$(MAKE) -C lib all

dirs:
	mkdir -p build
	mkdir -p build/boot

bootstrap: dirs
	i686-elf-as boot.s -o build/boot.o

clean:
	rm -rf build

kernel:  dirs
	cd build && i686-elf-gcc $(GCC_OPTS) \
	-c ../src/kernel.c \
	-c ../src/runtime/runtime.c \
	-std=gnu99 -ffreestanding -O2 -Wall -Wextra

link: bootstrap kernel
	i686-elf-gcc -T linker.ld -o build/$(OS_NAME).bin -ffreestanding -O2 -nostdlib \
	$(PREFIX)/$(TARGET)/lib/libc.a \
	build/*.o \
	-lgcc

verify: link
	grub-file --is-x86-multiboot ./build/$(OS_NAME).bin

iso: verify
	mkdir -p build/boot/grub
	cp build/$(OS_NAME).bin build/boot/$(OS_NAME).bin
	cp grub.cfg build/boot/grub/grub.cfg
	grub-mkrescue -o build/$(OS_NAME).iso build

run: link
	qemu-system-i386 -kernel build/$(OS_NAME).bin