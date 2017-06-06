.text
.global main

main:
		MOV		r3, #0x100
		MOV		r1, #0x5000
		STR		r3, [r1], #4
		ADD		r3, r3, #0x1
		STR		r3, [r1], #4
		ADD		r3, r3, #0x1
		STR		r3, [r1], #4
		ADD		r3, r3, #0x1
		STR		r3, [r1], #4
		ADD		r3, r3, #0x1
		STR		r3, [r1], #4
		ADD		r3, r3, #0x1
		STR		r3, [r1], #4
		ADD		r3, r3, #0x1
		STR		r3, [r1], #4
		ADD		r3, r3, #0x1
		STR		r3, [r1], #4
		ADD		r3, r3, #0x1

		MOV		r0, #8
		MOV		r1, #0 @i


		MOV		r5, #0x4000

loop:
		CMP		r1, #8
		BGE		done

		RSB		r6, r1, #7 @calculando 7 - i
		MOV		r6, r6, LSL #2 @multiplicando 7-i por 4
		ADD		r6, r6, #0x5000 @somando a base 5000, agora r6 tem o endereço de memória de b[7-i]

		LDR		r7, [r6], #4 @carregando valor de b[7-i] em r7
		STR		r7, [r5], #4 @guardando em a[i] o valor de b[7-1]


		ADD		r1, r1, #1
		BAL		loop
done:
		SWI 	0x123456
