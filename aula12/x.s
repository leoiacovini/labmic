1.1 irq.s
1.2. ?


1.3 irq.s
1.4 setup_linhaB (...) MOV pc lr

1.5 do_irq_interrupt

2.1 0x600001d2 -> 0110 0000 .... 1101 0010

2.2 ?

2.4. 0110

2.5 0xc0 -> do_irq_interrupt

2.6 0x04

2.7 0x3492

2.8 0x00 0x00 0x00 0x00 ??

3.1 0x3a0 (lr - #4)
3.2 0xdc -> <delay>
3.3 ?
3.4 0x246a
3.5 MSR cp_c, r0... MOV r3, sp
3.6 ?
