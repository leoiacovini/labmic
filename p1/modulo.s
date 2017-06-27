.text
.global main

size: .word 10 @ Tamanho da lista
lista: .word 13, 15, 8, 3, 8, 11, 14, 20, 5, 9
numero: .word 10
modulo: .space 100

main:
            LDR   r0, size @ carrega tamanho da lista
            LDR   r1, =lista @ ponteiro para a lista de numeros
            LDR   r2, =modulo @ ponteiro para a fila de modulos
            LDR   r3, numero @ Carrega numero divisor
            BL lista_modulos
            B done

@ Subrotina lista_modulos
@ recebe o tamanho em r0
@ recebe o inicio da lista de numeros em r1
@ recebe o local da memória para ser colocado em r2
@ recebe o divisor em r3
lista_modulos:
            STMFD   sp!, {r4-r12, lr} @ Empilha estado anterior
            MOV     r4, r1 @ Posicao atual na lista de numeros
            MOV     r5, r2 @ Posicao atual na lista de modulos
            MOV     r6, r3 @ Divisor
            MOV     r8, r0 @ Numeros que faltam
loop:
            LDR     r7, [r4], #4 @ Carrega Numero a ser processado, e avanca para proxima posica
            MOV     r1, r7 @ Carrega dividento
            MOV     r2, r6 @ Carrega divisor
            BL      divide @ Chama divide
            STR     r1, [r5], #4 @ Guarda resto (modulo) na proxima posicao da lista modulos
            SUBS    r8, r8, #1 @ Reduz em um o numero de elementos restantes
            BNE     loop @ Volta para o loop
            LDMEQFD sp!, {r4-r12, lr} @Desempilha estado anterior
            MOVEQ   pc, lr @ retorna da subrotina

@ Subrotina divide
@ Divide r1 por r2, resto no r1, e quociente no r0
divide:
            STMFD   sp!, {r3, lr} @ Empilha estado anterior
            CMP     r2, #0
            BEQ     end_div

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
end_div:
            LDMFD   sp!, {r3, lr} @ Restaura estado anterior
            MOV     pc, lr @ retorna da subrotina

done:
            SWI         0x123456 @ End
