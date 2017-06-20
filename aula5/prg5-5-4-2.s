.text
.global main

main:
		LDR		r1, =0xAAAA5555		@input
		LDR		r2, =0													@output
		LDR		r8, =0x5										@sequencia
		LDR		r9, =4													@tamanho da sequencia
		LDR		r0, =0 @i
		RSB		r3, r9, #33		@ 32 - i
		RSB		r5, r9, #32

loop:
		CMP		r0, r3
		BGE		done
		MOV		r4, r1, LSR r5
		MOV		r1, r1, LSL #1
		CMP		r4, r8
		MOV		r2, r2, LSL #1
		ADDEQ	r2, r2, #1
		ADD		r0, r0, #1
		BAL		loop
done:
		SWI 0x123456
