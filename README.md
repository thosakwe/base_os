# Running in QEMU
This is probably what you need.

```bash
make run
```

# Requirements
WIP. Current uses a hard-coded path to `~/opt/cross`.
In theory, though, you need an `i686-elf-gcc` cross-compiler
installed in `~/opt/cross`.

# Getting a C library
You need to download the sources of `newlib`, and
save them in `lib/newlib`. Then, run `make lib` to
build the C library.