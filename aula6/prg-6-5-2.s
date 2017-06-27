.text
.global main

stk: .word 0x87, 0x12, 0x43, 0x21
nstk: .word 0x4
stkaux: .space 100

main:
  LDR r13, =stk
  LDR r12, =stkaux
  LDR r11, =nstk
  LDR r9, =4
  LDR r3, [r11]        @ size counter
  MUL r10, r9, r3
  ADD r12, r12, r10
  LDMFD r13!, {r0, r1}  @ pop 2
  LDR r3, [r11]        @ size counter
  LDR r5, [r11]        @ size counter
  SUB r3, r3, #2        @ size = size - 2
swap:
  CMP r1, r0             @ r0 - r1 ?
  MOVEQ r2, r0
  MOVEQ r0, r1
  MOVEQ r1, r2
stkauxops:
  STMFD r12!, {r1}       @ stkaux.push(r0)
  SUBS r3, r3, #1        @ size = size - 1
  LDMPLFD r13!, {r1}       @ r1 = stk.pop
  BPL swap
backtostk:

done:
		SWI 	0x123456
