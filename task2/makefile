%.o: %.asm
	nasm -g -O1 -f elf -o $@ $<

all: lwca

lwca: start.o
	ld  -melf_i386 -o $@ $^  -lc -I/lib/ld-linux.so.2

clean:
	rm -f *.o lwca