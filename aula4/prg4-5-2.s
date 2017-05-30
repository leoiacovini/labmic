.text
.global main

main:
	@ Prep Work
	LDR r2, =0x5000 @ Endereco do Array = Array[0]
	LDR r7, =0x123 @ r4 = 0x0123
	STR r7, [r2, #0xA0] @ Load 0x123 em Array[5]
	B pos
	
pre:
	@ Pre-Indexed
	LDR r3, [r2, #0x0A0] @ Carrega Array[0 + 5] // 0xA0 = 5 * 32 = 160
	LDR r1, =0x02 @ 02
	ADD r0, r3, r1 @ R0 = R3 + R1
	STR r0, [r2, #0x0140] @ MEM[R2 + 0x0140] = R0
	SWI 0x123456

pos:
	@ Post-Indexed
	ADD r5, r2, #0xA0 @ r5 = pos 50A0
	LDR r3, [r5], #0xA0 @ Load Array[5] and set r5 to Array[10] post
	LDR r1, =0x02 @ 02
	ADD r0, r3, r1 @ R0 = R3 + R1
	STR r0, [r5] @ MEM[R2 + 0x0140] = R0
	SWI 0x0123456	
	
