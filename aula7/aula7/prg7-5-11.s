.text
.global main

tohex: .word 0x5F, 0x06, 0x3B, 0x2F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x67, 0x77, 0x7C, 0x59, 0x3E, 0x79, 0x71
main:
  LDR r0, =0x3ff5000 @ IOMODE address
  LDR r1, =0x1fc00 @IOMode switch input, 7-seg output
  LDR r2, =0x4 @ Constante 4
  LDR r9, =0x0 @ Estado anterior
  LDR r8, =0x0 @ Count
  LDR r6, =tohex
  LDR r3, =0x3ff5008 @IODATA
  LDR r5, =0x5F
  MOV r5, r5, LSL #10
  STR r5, [r3]
test:
  LDR r5, =0x0
  LDRB r4, =0x0
  LDRB r4, [r3]
  CMP r4, r9
  ADDNE r8, r8, #1
  MOVNE r9, r4
  CMP r8, #16
  LDREQ r8, =0x0
  MUL r5, r8, r2 @ multiplica por 4 o valor
  LDR r7, [r6, r5]
  MOV r7, r7, LSL #10
  STR r7, [r3]
  BL delay
  B pnc
delay:
  STMFD sp!, {r4-r12, lr}
  LDR r5, =0x000FFFFF
delay_dec:
  SUBS r5, r5, #0x1
  BNE delay_dec
  LDMFD sp!, {r4-r12, lr}
  MOV pc, lr
done:
  SWI  0x123456
