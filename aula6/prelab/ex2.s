.text
.global main

main:
    LDR r11, =0x8000
    LDR r10, =0x8000
    LDR r1,  =0xA
    STR r1, [r11], #4
    LDR r1,  =0xB
    STR r1, [r11], #4
    LDR r1,  =0xC
    STR r1, [r11], #4
    LDR r1,  =0xD
    STR r1, [r11], #4
    LDMIA r10, {r7,r4,r0,lr}
done:
		SWI 	0x123456
