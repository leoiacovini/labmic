.text
.global main

main:
				MOV		r0, #0x4000

				MOV		r1, #8
				STRB		r1, [r0], #1
				MOV		r1, #1
				STRB		r1, [r0], #1
				MOV		r1, #6
				STRB		r1, [r0], #1
				MOV		r1, #3
				STRB		r1, [r0], #1
				MOV		r1, #5
				STRB		r1, [r0], #1
				MOV		r1, #7
				STRB		r1, [r0], #1
				MOV		r1, #4
				STRB		r1, [r0], #1
				MOV		r1, #9
				STRB		r1, [r0], #1
				MOV		r1, #2


				STRB		r1, [r0], #1
				MOV		r1, #6
				STRB		r1, [r0], #1
				MOV		r1, #7
				STRB		r1, [r0], #1
				MOV		r1, #12
				STRB		r1, [r0], #1
				MOV		r1, #4
				STRB		r1, [r0], #1
				MOV		r1, #15
				STRB		r1, [r0], #1
				MOV		r1, #14
				STRB		r1, [r0], #1
				MOV		r1, #1
				STRB		r1, [r0], #1


				MOV		r1, #3
				MOV		r11, #0
				MOV		r10, #0
				MUL		r12, r1, r1
				ADD 	r12, r12, #1
				MUL		r11, r12, r1
				MOV 	r12, r11, LSR #1
				MOV		r11, #0
				@		r1 * (r1 * r1 + 1) / 2
loop: @ main loop
				@r11		percorre inicio das linhas
				@r10		percorre inicio das colunas
				BL		checkrow
				CMP		r9, #0
				BEQ		not_magic

				BL		checkcolumn
				CMP		r9, #0
				BEQ		not_magic

				CMP		r10, #0
				BLEQ		checkdiagonal1
				CMP		r9, #0
				BEQ		not_magic

				CMP		r10, #3
				BLEQ		checkdiagonal2
				CMP		r9, #0
				BEQ		not_magic

				ADD		r11, r11, r1	@ percorre inicio linhas
				ADD		r10, r10, #1    @ percorre inicio de colunas
				MUL 	r13, r1, r1
				CMP		r11, r13
				BLT		loop
				B		done


checkrow: @ funcao que chega linha
				MOV		r2, r11
				MOV		r8, #0x4000
				ADD		r8, r8, r2

				MOV		r3, #0
				MOV		r5, #0
loopcheckrow:
				LDRB		r4, [r8], #1
				ADD		r5, r5, r4
				ADD		r3, r3, #1
				CMP		r3, r1 @ vai até N
				BLT		loopcheckrow

				CMP		r5, r12
				MOVEQ	r9, #1
				MOVNE	r9, #0
				MOV		pc, r14

checkcolumn: @funcao que checa coluna
				MOV		r2, r10
				MOV		r8, #0x4000
				ADD		r8, r8, r2
				MOV		r3, #0
				MOV		r5, #0
loopcheckcolumn:
				LDRB		r4, [r8], r1
				ADD		r5, r5, r4
				ADD		r3, r3, #1
				CMP		r3, r1 @ vai até N
				BLT		loopcheckcolumn

				CMP		r5, r12
				MOVEQ	r9, #1
				MOVNE	r9, #0
				MOV		pc, r14

checkdiagonal1:
				MOV		r3, #0
				MOV		r4, #0
				MOV		r8, #0x4000
				MOV		r6, #0
				ADD		r6, r1, #1
loop2:
				LDRB		r5, [r8], r6
				ADD		r4, r4, r5
				ADD		r3, r3, #1
				CMP		r3, r1
				BLT		loop2
				CMP		r4, r12
				MOVEQ	r9, #1
				MOVNE	r9, #0
				MOV		pc, r14

checkdiagonal2:
				MOV		r3, #0
				MOV		r4, #0
				MOV		r8, #0x4000
				MOV		r6, #0
				SUB		r6, r1, #1
				ADD		r8, r8, r6
loop3:
				LDRB		r5, [r8], r6
				ADD		r4, r4, r5
				ADD		r3, r3, #1
				CMP		r3, r1
				BLT		loop3
				CMP		r4, r12
				MOVEQ	r9, #1
				MOVNE	r9, #0
				MOV		pc, r14

not_magic:

done:
	SWI 0x123456
