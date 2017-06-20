### Planejamento - Capítulo 6 - Subroutines
#### 1. O que há de errado com as seguintes instruções?
```assembly
a) STMIA r5!, {r5, r4, r9}
b) LDMDA r2, {}
c) STMDB r15!, [r0-r3, r4, lr}
```
a) O valor guardado por r5 é imprevisível, uma vez que ele é alterado durante a execução. O registrador r9 é um _high register_, e não é permitido.
b) Não é possível executar LDM sem nenhum valor de registrador.
c) Uso de colchetes ao invés de chaves. Registrador r15 é reservado para o Program Counter (PC).

#### 2. Se o registrador r6 possui 0x8000 (como ponteiro para a memória); após executar
```assembly
LDMIA r6,{r7,r4,r0,lr}
```
o que fica em r0, r4, r7 e em lr?

Considerando os valores do exercício 3, temos:
| Reg | Address |   Values   |
| --- | ------- | ---------- |
| r0  | 0x8000  | 0xBABE0000 |
| r4  | 0x8004  | 0x12340000 |
| r7  | 0x8008  | 0x00008888 |
| lr  | 0x800C  | 0xFEEDDEAF |

### 3. Descreva a memória e conteúdos dos registradores após a instrução:
```assembly
LDMIA r3!, {r0,r1,r2}
```

Assuma que a memória é:
| Addrs  | Values     |
| ------ | ---------- |
| 0x8010 | 0x00000001 |
| 0x800C | 0xFEEDDEAF |
| 0x8008 | 0x00008888 |
| 0x8004 | 0x12340000 |
| 0x8000 | 0xBABE0000 |

E os registradores:
| Reg |   Values   |
| --- | ---------- |
| r0  | 0x13       |
| r1  | 0xffffffff |
| r2  | 0xeeeeeeee |
| r3  | 0x8000     |

R.:
| Reg |   Values   |
| --- | ---------- |
| r0  | 0xBABE0000 |
| r1  | 0x12340000 |
| r2  | 0x00008888 |
| r3  | 0x800C     |

#### 4. Suponha que a pilha esteja como o diagrama abaixo. Que instrução seria necessária para sair do estado original e ir para o estado a), depois b) e depois c)?

| Addresses |  Original  |      A     |      B     |      C     |
| --------- | ---------- | ---------- | ---------- | ---------- |
| 0x8010    | 0x1        | 0x1        | 0x1        | 0x1        |
| 0x800C    | 0xfeeddeaf | 0xfeeddeaf | 0xfeeddeaf | 0xfeeddeaf |
| 0x8008    |            | 0xbabe2222 | 0xbabe2222 |            |
| 0x8004    |            |            | 0x12340000 |            |
| 0x8000    |            |            |            |            |

```assembly
STMFA r13!, {r0}
STMFA r13!, {r1}
LDMFA r13!, {r4-r5}
```
