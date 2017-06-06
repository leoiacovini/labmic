.text
.global main

main:
factorial:
	MOV r6, #0xA
	MOV r4, r6

loop:
	SUBS r4, r4, #1
	MULNE r6, r4, r6
	MOVNE r7, r6
	BNE loop
	SWI 0x123456
