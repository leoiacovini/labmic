.text
.global main

main:
    LDR r11, =0x8000
    LDR r10, =0x8000
    LDR r1,  =0xbabe0000
    STR r1, [r11], #4
    LDR r1,  =0x12340000
    STR r1, [r11], #4
    LDR r1,  =0x00008888
    STR r1, [r11], #4
    LDR r1,  =0xfeeddeaf
    STR r1, [r11], #4
    LDR r1,  =0x1
    STR r1, [r11], #4
    LDR r0, =0x13
    LDR r1, =0xffffffff
    LDR r2, =0xeeeeeeee
    LDR r3, =0x8000
    LDMIA r3!, {r0,r1,r2}
done:
		SWI 	0x123456
