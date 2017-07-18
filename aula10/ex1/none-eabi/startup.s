.section INTERRUPT_VECTOR, "x"
.global _Reset

.equ CPSR_MODE_SVR, 0x13
.equ CPSR_MODE_UNDEFINED, 0x1B

.equ CPSR_IRQ_INHIBIT, 0x80
.equ CPSR_FIQ_INHIBIT, 0x40

_Reset:
  B Reset_Handler /* Reset */
  B Undefined_Handler /* Undefined */
  B . /* SWI */
  B . /* Prefetch Abort */
  B . /* Data Abort */
  B . /* reserved */
  B . /* IRQ */
  B . /* FIQ */

Reset_Handler:
  LDR r1, =0x1000 @ stack size
  LDR r2, =stack_top
  MOV sp, r2
  ADD r2, r2, r1
  MOV r0, #(CPSR_MODE_UNDEFINED | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT)
  MSR cpsr_c, r0
  MOV sp, r2
  MOV r0, #(CPSR_MODE_SVR | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT)
  MSR cpsr_c, r0
  BL c_entry
  .word 0xffffffff
  MOV r1, #0x69
  B .

Undefined_Handler:
  STMFD sp!, {r0-r12, lr}

  LDMFD sp!, {r0-r12, pc}^
  B .
