	.text
	.globl main

main:
	MOV r1, #13
	MOV r2, #2
	CMP r2, #0
	BEQ divide_end

	MOV r0, #0
	MOV r3, #1

start:
	CMP r2, r1
	MOVLS r2, r2, LSL #1
	MOVLS r3, r3, LSL #1
	BLS start

next:
	CMP r1, r2
	SUBCS r1, r1, r2
	ADDCS r0, r0, r3
	MOVS r3, r3, LSR #1
	MOVCC r2, r2, LSR #1
	BCC next

divide_end:
	SWI #0x123456
