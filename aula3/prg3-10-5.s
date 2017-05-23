	.text
	.globl main

main:
	MOV r0, #0xFFFFFFF2	
	MOV r1, #0xFFFFFFFC

	CMP r0, #0
	MOV r2, #0
	MOVMI r2, #1
	MVNMI r0, r0
	ADDMI r0, r0, #1
	
	CMP r1, #0
	MOV r3, #0
	MOVMI r3, #1
	MVNMI r1, r1
	ADDMI r1, r1, #1

	UMULL r4, r5, r0, r1
	EOR r6, r2, r3
	CMP r6, #0
	MVNNE r4, r4
	MVNNE r5, r5
	ADDNES r4, r4, #1
	ADDVS r5, r5, #1
	SWI #0x123456
	
