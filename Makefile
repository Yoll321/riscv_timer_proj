default: bin/main.elf

bin/main.o: src/main.c
	riscv64-unknown-elf-gcc -c -g -O0 -ffreestanding -march=rv32i -mabi=ilp32 \
	-o bin/main.o src/main.c

bin/start.o: src/start.s
	riscv64-unknown-elf-as -march=rv32i -mabi=ilp32 -o bin/start.o src/start.s

bin/main.elf: bin/main.o bin/start.o src/baremetal.ld
	riscv64-unknown-elf-ld -T src/baremetal.ld -m elf32lriscv -o bin/main.elf bin/main.o bin/start.o

run: bin/main.elf
	@echo "Ctrl-A C for QEMU console, then quit to exit"
	cd bin && qemu-system-riscv32 -nographic -serial mon:stdio -machine virt -bios main.elf -gdb tcp::1234

clear:
	rm bin/*.o
