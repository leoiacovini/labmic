.text
.globl main

main:
      @array A
      LDR r3, =0x101  @ o valor que vai ser colocado nas posições do array
      LDR r1, =0x5000 @ para acessar as posições do array
      STRB r3, [r1], #1  @ arrayA[0] = 0x101     0x5000
      ADD r3, r3, #0x1
      STRB r3, [r1], #1  @ arrayA[1] = 0x102     0x5004
      ADD r3, r3, #0x1
      STRB r3, [r1], #1  @ arrayA[2] = 0x103
      ADD r3, r3, #0x1
      STRB r3, [r1], #1  @ arrayA[3] = 0x104
      ADD r3, r3, #0x1
      STRB r3, [r1], #1  @ arrayA[4] = 0x105
      ADD r3, r3, #0x1
      STRB r3, [r1], #1  @ arrayA[5] = 0x106
      ADD r3, r3, #0x1
      STRB r3, [r1], #1  @ arrayA[6] = 0x107
      ADD r3, r3, #0x1
      STRB r3, [r1], #1  @ arrayA[7] = 0x108
      ADD r3, r3, #0x1
      STRB r3, [r1], #1  @ arrayA[8] = 0x109
      ADD r3, r3, #0x1
      STRB r3, [r1], #1  @ arrayA[9] = 0x10A

      @array B
      LDR r3, =0x301  @ o valor que vai ser colocado nas posições do array
      LDR r2, =0x4000 @ para acessar as posições do array
      STRB r3, [r2], #1  @ arrayB[0] = 0x301     0x4000
      ADD r3, r3, #0x1
      STRB r3, [r2], #1  @ arrayB[1] = 0x302     0x4004
      ADD r3, r3, #0x1
      STRB r3, [r2], #1  @ arrayB[2] = 0x303
      ADD r3, r3, #0x1
      STRB r3, [r2], #1  @ arrayB[3] = 0x304
      ADD r3, r3, #0x1
      STRB r3, [r2], #1  @ arrayB[4] = 0x305
      ADD r3, r3, #0x1
      STRB r3, [r2], #1  @ arrayB[5] = 0x306
      ADD r3, r3, #0x1
      STRB r3, [r2], #1  @ arrayB[6] = 0x307
      ADD r3, r3, #0x1
      STRB r3, [r2], #1  @ arrayB[7] = 0x308
      ADD r3, r3, #0x1
      STRB r3, [r2], #1  @ arrayB[8] = 0x309
      ADD r3, r3, #0x1
      STRB r3, [r2], #1  @ arrayB[9] = 0x30A

      @inicializacao
      LDR r1, =0x5000 @ para acessar o arrayA (que começa na posicao 0x5000)
      LDR r2, =0x4000 @ para acessar o arrayB (que começa na posicao 0x4000)
      LDR r3, =0x0     @ i = 0
      LDR r4, =0x01  @ c = constante

      @ preciso de a[i] = b[i] + c

loop: LDRB r5, [r2], #1   @ r5 = b[i]  carrega em r5 o que tem em [r2]  e   r2 = r2 + #1
      ADD r5, r5, r4     @ r5 = b[i] + c
      STRB r5, [r1], #1   @ a[i] = b[i] + c   e   r1 = r1 + #1

      ADD r3, r3, #0x1  @ i ++
      CMP r3, #0xA      @ i < 10
      BMI loop           @ volta pro loop: se i < 10
      SWI #0x123456
