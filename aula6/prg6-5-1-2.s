.text
.global main

main:
  MOV		r13, #0x5000
  MOV		r1, #1	; b
  MOV		r2, #2	; c
  MOV		r3, #3	; d
  MOV		r4, #4	; a

  ;		Passando argumentos por memória
  STR		r1, [r13], #4
  STR		r2, [r13], #4
  STR		r3, [r13], #4
  MOV		r13, #0x100
  BL		func2
  B		fim

  func2:
    LDR		r1, [r13], #4 ; b
    LDR		r2, [r13], #4 ; c
    LDR		r3, [r13], #4 ; d
    MOV		r4, #0
    ADD		r4, r4, r1
    ADD		r4, r4, r2
    ADD		r4, r4, r3
    MOV		pc, r14

  fim:
    SWI 	0x123456
