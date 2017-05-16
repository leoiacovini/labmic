	.text
	.globl main
main:
	LDR r0, =0xFFFF0000
	LDR r1, =0x87654321
	ADDS r3, r0, r1
	SWI 0x123456
