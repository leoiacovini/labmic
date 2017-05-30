
B.1)
  LDRSB r13, [r0]           ; r13 = 0x06
  LDRSH r13, [r0]           ; r13 = 0xfffffc06
  LDR r13,[r0]              ; r13 = 0xff03fc06
  LDRB r13,[r0]             ; r13 = 0x06

B.2)
  STR r6, [r4,#4]           ; pre-indexed
  LDR r3, [r12], #6         ; pos-indexed
  LDRB r4, [r3,r2]!         ; pre-indexed
  LDRSH r12, [r6]           ; pos-indexed

B.3)
  STRB r9, [r3, r4]         ; MEM[r3 + r4] = MEM[0x4020] = r9[1]r9[0]
  LDRB r8,[r3,r4,LSL #3]    ; r8 = MEM[r3*8 + r4][1]MEM[r3*8 + r4][0] = MEM[0x4100][1]MEM[0x4100][0]
  LDR r7, [r3], r4          ; r7 = MEM[r3] = MEM[0x4000]
  STRB r6, [r3], r4, ASR #2 ; r6 = MEM[r3] = MEM[0x4000]

B.4)
Só é possível usar Operand2 (LSL, ASL, etc.) na notação pre-indexada.
