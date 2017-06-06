.text
.global main

main:
	LDR r4, =0x5000 @ Endereco do resultado
	LDR r5, =0x05 @ Itens na sequencia
	LDR r7, =0x5004 @ Endereco inicial
	LDR r6, =0x5004 @ Endereo apontado
	LDR r3, =0x0 @ Value to be stored

	LDR r3, =0x3
	STR r3, [r6], #4
	LDR r3, =0x2
	STR r3, [r6], #4
	LDR r3, =0x0A
	STR r3, [r6], #4
	LDR r3, =0x4
	STR r3, [r6], #4
	LDR r3, =0x8
	STR r3, [r6], #4

	MOV r6, r7 @ Reset endereco apontado para o endereco incial
	LDR r0, =0x0 @ Menor valor possivel
	
loop:
	LDR r1, [r6], #4
	CMP r0, r1
	MOVMI r0, r1
	SUBS r5, r5, #1
	BNE loop
	BEQ termina

termina:
	STR r0, [r4]
	SWI 0x123456
