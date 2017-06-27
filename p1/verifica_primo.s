.text
.global main

main:
            LDR     r4, =0x06 @ Numero a ser verificado
            MOV     r5, r4    @ Proximo numero a dividir
            LDR     r6, =0x00 @ Contatador de divisoes
loop:
            MOV     r1, r4 @ Carrega Dividendo
            MOV     r2, r5 @ Carrega Divisor
            CMP     r5, #0x00 @ Compara se ja estamos no 0
            BEQ     checagem @ Caso positivo entao vamos para checagem
            BLNE     divide @ Caso nao, entao dividimo r4 por r5
continue_loop:
            CMP     r1, #0 @ Verifica se o resto eh 0
            ADDEQ   r6, r6, #1 @ Se sim, entao a divisao deu certo, incrementamos o r6
            SUB     r5, r5, #1 @ Tiramos 1 do r5 para a proxima rodada
            B       loop @ Volta pro Loop
            
            
divide: @ Divide r1 por r2, resto no r1, e quociente no r0
            CMP     r2, #0
            BEQ     continue_loop
            
            MOV     r0, #0
            MOV     r3, #1
            
divide_start:
            CMP     r2, r1
            MOVLS   r2, r2, LSL #1
            MOVLS   r3, r3, LSL #1
            BLS     divide_start
            
divide_next:
            CMP     r1, r2
            SUBCS   r1, r1, r2
            ADDCS   r0, r0, r3
            MOVS    r3, r3, LSR #1
            MOVCC   r2, r2, LSR #1
            BCC     divide_next
            MOV     pc, lr
            
            
checagem:
            CMP     r6, #2  @ Compara se tivemos mais que 2 divisoes entre 1 e r4
            LDRNE   r10, =0 @ r10 = 0 caso numero nao seja primo
            LDREQ   r10, =1 @ r10 = 1 caso numero seja primo
            
            
done:
            SWI         0x123456 @ End

@ Verificar r10 no final da execucao
@ 1 = primo
@ 0 = nao primo