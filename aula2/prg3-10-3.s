	.text
	.globl main

main:
	LDR	r0, =0x1
	MOV 	r0, r0, LSL #5
	SWI 	0x123456
