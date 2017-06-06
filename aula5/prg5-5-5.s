.text
.global main

main:
	LDR r0, =0b0001101 @ Sequencia binaria
	LDR r1, =0x0 @ Zera r1
	LDR r2, =0x20 @ Tamanho da sequencia (32 bits)
	
loop:
	MOVS r0, r0, LSL #1 @ Shift left by 1 bit
	ADDHS r1, r1, #1 @ Incrementa r1 caso o bit shiftado seja 1
	SUBS r2, r2, #1 @ Diminui em 1 o numero de bits faltando
	BNE loop
	BEQ finaliza

finaliza:
	MOVS r1, r1, LSR #1 @ Divide por 2
	LDRCS r1, =0x01 @ Carrega 1 em r1 se carry esta setado
	LDRCC r1, =0x00 @ Carrega 0 em r1 se carry nao esta setado
	SWI 0x0123456
