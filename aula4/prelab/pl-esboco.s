.text
.globl main

main:
      LDR r3, =0x4000
      LDR r4, =0x5000

      LDR r2, =0x101
      STR r2, [r4], #4
      ADD r2, r2, #0x1
      STR r2, [r4], #4
      ADD r2, r2, #0x1
      STR r2, [r4], #4
      ADD r2, r2, #0x1
      STR r2, [r4], #4
      ADD r2, r2, #0x1
      STR r2, [r4], #4
      ADD r2, r2, #0x1
      STR r2, [r4], #4
      ADD r2, r2, #0x1
      STR r2, [r4], #4
      ADD r2, r2, #0x1
      STR r2, [r4], #4

      LDR r2, =0x301
      STR r2, [r3], #4
      ADD r2, r2, #0x1
      STR r2, [r3], #4
      ADD r2, r2, #0x1
      STR r2, [r3], #4
      ADD r2, r2, #0x1
      STR r2, [r3], #4
      ADD r2, r2, #0x1
      STR r2, [r3], #4
      ADD r2, r2, #0x1
      STR r2, [r3], #4
      ADD r2, r2, #0x1
      STR r2, [r3], #4
      ADD r2, r2, #0x1
      STR r2, [r3], #4

      LDR r3, =0x4000
      LDR r4, =0x5000
      LDR r2, =0x0
loop: RSB r1, r2, #0x7
      LDR r5, [r4, r1, LSL#2]
      STR r5, [r3, r2, LSL#2]
      ADD r2, r2, #0x1
      CMP r2, #0x8
      BMI loop
      SWI #0x123456
