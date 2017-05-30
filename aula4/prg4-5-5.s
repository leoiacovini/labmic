.text
.global main

main:
	LDRB r0, =0x00 @ 0
	LDRB r1, =0x01 @ 1
	LDR r2, =0x4000 @ Start address
	MOV r7, #10 @ Remaining loops
	STRB r0, [r2], #1
	STRB r1, [r2], #1

loop:
	ADD r0, r0, r1
	STRB r0, [r2], #1
	MOV r3, r0
	MOV r0, r1
	MOV r1, r3
	SUBS r7, r7, #1 @ R7 = R7 - 1
	BNE loop

end:
	SWI 0x123456
