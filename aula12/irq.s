.global _start
.text
.equ CPSR_MODE_USER, 0x10

.equ CPSR_MODE_FIQ, 0x11
.equ CPSR_MODE_IRQ, 0x12
.equ CPSR_MODE_SVR, 0x13
.equ CPSR_MODE_ABORT, 0x17
.equ CPSR_MODE_UNDEFINED, 0x1B
.equ CPSR_MODE_SYSTEM, 0x1F

.equ CPSR_IRQ_INHIBIT, 0x80
.equ CPSR_FIQ_INHIBIT, 0x40

_start:
@ Vetor de interrupcoes
  b _Reset @posição 0x00 - Reset
  ldr pc, _undefined_instruction @posição 0x04 - Intrução não-definida
  ldr pc, _software_interrupt @posição 0x08 - Interrupção de Software
  ldr pc, _prefetch_abort @posição 0x0C - Prefetch Abort
  ldr pc, _data_abort @posição x10 - Data Abort
  ldr pc, _not_used @posição 0x14 - Não utilizado
  ldr pc, _irq @posição 0x18 - Interrupção (IRQ)
  ldr pc, _fiq @posição 0x1C - Interrupção(FIQ)

_undefined_instruction: .word undefined_instruction
_software_interrupt: .word software_interrupt
_prefetch_abort: .word prefetch_abort
_data_abort: .word data_abort
_not_used: .word not_used
_irq: .word irq
_fiq: .word fiq

INTPND: .word 0x10140000 @Interrupt status register
INTSEL: .word 0x1014000C @interrupt select register( 0 = irq, 1 = fiq)
INTEN: .word 0x10140010 @interrupt enable register
TIMER0L: .word 0x101E2000 @Timer 0 load register
TIMER0V: .word 0x101E2004 @Timer 0 value registers
TIMER0C: .word 0x101E2008 @timer 0 control register
TIMER0X: .word 0x101E200c @timer 0 interrupt clear register

_Reset:
  LDR r1, =0x1000 @ stack size
  LDR r2, =stack_top
  MOV sp, r2 @set svr stack
  ADD r2, r2, r1 @ adds space on stack
  MOV r0, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT) @ load irq mode cpsr value
  MSR cpsr_c, r0 @ go to irq mode
  MOV sp, r2 @ set irq stack
  MOV r0, #(CPSR_MODE_SVR | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT) @ load svr mode cpsr value
  MSR cpsr_c, r0 @ go to svr mode
  bl main
  b .
undefined_instruction:
  b .
software_interrupt:
  b do_software_interrupt @vai para o handler de interrupções de software
prefetch_abort:
  b .
data_abort:
  b .
not_used:
  b .
irq:
  b do_irq_interrupt @vai para o handler de interrupções IRQ
fiq:
  b .

do_software_interrupt: @Rotina de Interrupçãode software
  add r1, r2, r3 @r1 = r2 + r3
  mov pc, r14 @volta p/ o endereço armazenado em r14

fetch_linha:
  LDR r11, current_task
  CMP r11, #0
  LDREQ r12, =linhaA
  CMP r11, #1
  LDREQ r12, =linhaB
  MOV pc, lr

do_irq_interrupt: @Rotina de interrupções IRQ
  SUB lr, lr, #4

  STMFD sp!, {r11, lr}
  STMFD sp!, {r12}

  BL fetch_linha

  LDMFD sp!, {r11} @ r11=r12
  STMFD r12!, {r11}
  LDMFD sp!, {r11} @ r11=r11
  STMFD r12!, {r11}
  STMFD r12!, {r0 - r10}
  LDMFD sp!, {r1} @ r1=pc (lr)
  MOV r0, #(CPSR_MODE_SVR | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT) @ load irq mode cpsr value
  MSR cpsr_c, r0 @ go to irq mode
  MOV r2, lr @r2 = lr (r14)
  MOV r3, sp @r3 = sp (r13)
  MOV r0, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT) @ load irq mode cpsr value
  MSR cpsr_c, r0 @ go to irq mode

  MRS R0, spsr @ r0 = cpsr
  STMFD r12!, {r0-r3} @ puts on linha sp lr pc cpsr

  LDR r0, INTPND @Carrega o registrador de status de interrupção
  LDR r0, [r0]
  TST r0, #0x0010 @verifica se é uma interupção de timer

  LDR r0, =current_task
  LDR r1, [r0] @ load current_task value
  LDR r2, =num_tasks
  LDR r2, [r2] @num_tasks
  ADD r1, r1, #1
  CMP r1, r2 @ num_tasks starts on 1 not zero. So if its equal, goes to 0
  LDREQ r1, =0
  STR r1, [r0] @ guarda o current_task
  BL fetch_linha

  SUB r12, r12, #68
  @LDMFD r12, {r0}
  LDMFD r12!, {r0-r3} @ pega os regs sp lr pc cpsr novos
  bic r0,r0,#0x80 @reativa a interrupção


  MOV r4, #(CPSR_MODE_SVR | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT) @ load svr mode cpsr value
  MSR cpsr_c, r4 @ go to svr mode

  MOV r3, sp @ recupera o sp da nova current_task
  MOV r2, lr @ mesmo para o lr

  MOV r4, #(CPSR_MODE_IRQ | CPSR_IRQ_INHIBIT | CPSR_FIQ_INHIBIT) @ load irq mode cpsr value
  MSR cpsr_c, r4 @ go to irq mode

  MSR spsr_cxsf, r0

  @ADD r12, r12, #56
  STMFD sp!, {r1} @ pc
  @STMFD sp!, {r2} @ lr
  @STMFD sp!, {r3} @ sp
  BL c_entry @vai para o rotina de tratamento da interupção de timer
  LDMFD r12, {r0-r12} @retorna registradores ao estado anterior

  LDMFD sp!, {pc}^

timer_init:
  LDR r0, INTEN
  LDR r1,=0x10 @bit 4 for timer 0 interrupt enable
  STR r1,[r0]
  LDR r0, TIMER0C
  LDR r1, [r0]
  MOV r1, #0xA0 @enable timer module
  STR r1, [r0]
  LDR r0, TIMER0V
  MOV r1, #0x1f @setting timer value
  STR r1,[r0]
  mrs r0, cpsr
  bic r0,r0,#0x80
  msr cpsr_c,r0 @enabling interrupts in the cpsr
  mov pc, lr

setup_linhaB:
  LDR r12, =linhaB
  LDR r1, =0x1
  LDR r2, =0x2
  LDR r3, =0x3
  LDR r4, =0x4
  LDR r5, =0x5
  LDR r6, =0x6
  LDR r7, =0x7
  LDR r8, =0x8
  LDR r9, =0x9
  LDR r10, =0x10
  LDR r11, =0x12
  STMFD r12!, {r11} @ stack r12
  LDR r11, =0x11
  STMFD r12!, {r0-r11} @ stack r0-r11
  LDR r3, =stack_top
  SUB r3, r3, #0x1000 @sp (r13)
  LDR r2, =0x14 @ lr (r14)
  LDR r1, =imprime3 @pc (r15)
  MRS r0, cpsr
  bic r0,r0,#0x80
  STMFD r12!, {r0-r3} @ mock r12-r14. pc é o imprime3. SPSR é clonado do CPSR
  MOV pc, lr

main:
  bl setup_linhaB
  bl timer_init @initialize interrupts and timer 0
imp:
  bl imprime2
  b imp


@  r12 r11 r10 r9 r8 r7 r6 r5 r4 r3 r2 r1 0 sp lr pc cpsr
top_linhaA: .space 100
linhaA: .space 4
top_linhaB: .space 100
linhaB: .space 4

current_task: .word 0
num_tasks: .word 2