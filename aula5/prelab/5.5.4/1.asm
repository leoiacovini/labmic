;		LDR		r1, =0b00101101100000000000000000000000	;test 1
;   expect     0b00000100100000000000000000000000
LDR		r1, =0b10110110110110110110110110111111     ;test 2
;		expect 0b00010010010010010010010010010000
MOV		r4, #0						; STATE
MOV		r3, #0 						; i
MOV		r5, #0						;  output
loop
  CMP		r3, #32
  BGE		done
  MOV		r0, r1
  LSL		r0, r0, r3
  LSR		r0, r0, #31    ; extrair para r0 bit a bit do input

  ; mudar de estado
  CMP		r4, #0
  BEQ		state0
  CMP		r4, #1
  BEQ		state1
  CMP		r4, #2
  BEQ		state2
  CMP		r4, #3
  BEQ		state3
  CMP		r4, #4
  BEQ		state4

state0
  CMP		r0, #0
  MOVEQ	r4, #0				; se input for 0 vai pra s0
  MOVNE	r4, #1				; se input for 1 vai pra s1
  BAL		next
state1
  CMP		r0, #0
  MOVEQ	r4, #2				; se input for 0 vai pra s2
  MOVNE	r4, #0				; se input for 1 vai pra s0
  BAL		next
state2
  CMP		r0, #0
  MOVEQ	r4, #0				; se input for 0 vai pra s0
  MOVNE	r4, #3				; se input for 1 vai pra s3
  BAL		next
state3
  CMP		r0, #0
  MOVEQ	r4, #0				; se input for 0 vai pra s0
  MOVNE	r4, #4				; se input for 1 vai pra s4
  MOVNE	r6, #1        ; se input 1, coloca 1 em r6
  RSBNE		r7, r3, #31   ; se input 1, calcula 31 - i
  LSLNE	 	r6, r6, r7    ; se input 1, shift left de 31 - 1 no valor 1
  ADDNE 	r5, r5, r6    ; se input 1, soma o calculado acima no output
  BAL			next
state4
  CMP		r0, #0
  MOVEQ	r4, #2				; se input for 0 vai pra s2
  MOVNE	r4, #4				; se input for 1 vai pra s4
  BAL		next

next
  ADD		r3, r3, #1   ; i++
  B		loop           ; foda-se
done
