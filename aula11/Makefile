
all: irq.o irq.elf

irq.o:
	arm-none-eabi-as -mcpu=arm926ej-s -g irq.s -o irq.o
irq.elf: irq.o
	arm-none-eabi-ld -T irqld.ld -o irq.elf irq.o
clean:
	rm *.o
	rm *.elf

.PHONY: all clean
