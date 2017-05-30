.text
.globl main

main:
  LDR r3, =0x4000
  LDR r4, =0x5000
  LDR r2, =0x0
loop:
  RSB r1, r2, #0x8
  ADD r2, r2, #0x1
  CMP r2, #0x8
  BGE loop
  SWI #0x123456
