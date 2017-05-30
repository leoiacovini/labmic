  .text
  .globl main

main:
  LDR r1, =0xff03fc06
  MOV r0, #0x24
  STR r1, [r0]

  LDRSB r2, [r0]
  LDRSH r2, [r0]
  LDR r2,[r0]
  LDRB r2,[r0]

  SWI #0x123456
