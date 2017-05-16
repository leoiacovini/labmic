	.text
	.globl main
main:
	LDR r0, =0xFFFFFFFF
	LDR r1, =0x12345678
	ADDS r2, r0, r1
	SWI 0x123456
