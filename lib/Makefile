PREFIX=/Users/thosakwe/opt/cross
TARGET=i686-elf
CONFIGURE_FLAGS=CC=i686-elf-gcc CFLAGS="-std=gnu99 -ffreestanding -O2" \
	LDFLAGS="-ffreestanding -O2 -nostdlib -lgcc" CPP=i686-elf-g++ CXX=i686-elf-g++ \
	--host=$(TARGET) --prefix=$(PREFIX)

.PHONY: all newlib glibc

all: newlib

newlib:
	mkdir -p newlib-build
	cd newlib-build && ../newlib/newlib/configure $(CONFIGURE_FLAGS) --disable-newlib-supplied-syscalls
	$(MAKE) -C newlib-build
	$(MAKE) -C newlib-build install

glibc:
	mkdir -p glibc-2.27-build
	cd glibc-2.27-build && ../glibc-2.27/configure $(CONFIGURE_FLAGS)
	$(MAKE) -C glibc-2.27