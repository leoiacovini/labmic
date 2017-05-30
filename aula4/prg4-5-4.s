.text
.global main

main:
	LDR r1, =0x5000 @ Endereco inicial do Array
	LDR r2, =0x08 @ Numero de itens no Array
	LDR r7, =0x0 @ Load with zero
	B ponteiro

indices:
	LDR r3, =0x0 @ i = 0

start_indices:
	STRB r7, [r1, r3] @ Set zero in position
	ADD r3, r3, #1 @ Go to next position
	CMP r3, r2 @ Check if pos < max
	BLT start_indices @ Loop if pos < max

ponteiro:
	MOV r3, r1 @ Load starting address

start_ponteiro:
	STRB r7, [r3], #1 @ Store to Array[pos] and increment
	ADD r4, r1, r2 @ Final Array Address
	CMP r3, r4 @ Check if pos < max
	BLT start_ponteiro @ Loop if pos < max
