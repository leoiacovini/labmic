.text
.global main

tohex: .word 0x5F, 0x06, 0x3B, 0x2F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x67, 0x77, 0x7C, 0x59, 0x3E, 0x79, 0x71
main:
  LDR r0, =0x3ff5000 @ IOMODE address
  LDR r1, =0xf0 @IOMode
  STR r1, [r0]
  LDR r3, =0x3ff5008 @IODATA
  LDR r4, =0x0
  STR r4, [r3]
pnc:
  LDR r5, =0x0
  LDR r4, =0x0
  LDR r4, [r3]
  MOV r8, r4, LSR #4
  MOV r8, r8, LSL #4
  SUB r4, r4, r8
  MOV r5, r4, LSL #4
  ADD r5, r5, r4
  STR r5, [r3]
  B pnc
done:
  SWI  0x123456
