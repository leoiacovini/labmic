	.text
	.globl main
main:
	LDR r0, =0x67654321
	LDR r1, =0x23110000
	ADDS r2, r0, r1
	SWI 0x123456
