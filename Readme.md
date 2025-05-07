## Структура процессора

Программная реализация однотактного процессора на транзисторах, который реализует маленькое модмножество архитектуры MIPS.

## Реализация базовых инструкций.

`lw`, `sw`, `add`, `sub`, `and`, `or`, `slt`, `beq`, `addi`, `andi`, `bne`, `j`, `jal`, `jr`.

Команды кодируются следующим образом:

| Команда | opcode | rs    | rt    | imm              |
|---------|--------|-------|-------|------------------|
| lw      | 100011 | xxxxx | xxxxx | xxxxxxxxxxxxxxxx |
| sw      | 101011 | xxxxx | xxxxx | xxxxxxxxxxxxxxxx |
| beq     | 000100 | xxxxx | xxxxx | xxxxxxxxxxxxxxxx |

| Команда | opcode | rs    | rt    | rd    | shamt | funct  |
|---------|--------|-------|-------|-------|-------|--------|
| add     | 000000 | xxxxx | xxxxx | xxxxx | 00000 | 100000 |
| sub     | 000000 | xxxxx | xxxxx | xxxxx | 00000 | 100010 |
| and     | 000000 | xxxxx | xxxxx | xxxxx | 00000 | 100100 |
| or      | 000000 | xxxxx | xxxxx | xxxxx | 00000 | 100101 |
| slt     | 000000 | xxxxx | xxxxx | xxxxx | 00000 | 101010 |

| Команда | opcode | rs    | rt    | imm              |
|---------|--------|-------|-------|------------------|
| addi    | 001000 | xxxxx | xxxxx | xxxxxxxxxxxxxxxx |
| andi    | 001100 | xxxxx | xxxxx | xxxxxxxxxxxxxxxx |
| bne     | 000101 | xxxxx | xxxxx | xxxxxxxxxxxxxxxx |

| Команда | opcode | addr                       |
|---------|--------|----------------------------|
| j       | 000010 | xxxxxxxxxxxxxxxxxxxxxxxxxx |
| jal     | 000011 | xxxxxxxxxxxxxxxxxxxxxxxxxx |

| Команда | opcode | rs    | rt    | rd    | shamt | funct  |
|---------|--------|-------|-------|-------|-------|--------|
| jr      | 000000 | xxxxx | 00000 | 00000 | 00000 | 001000 |

`addr` определяет новый PC следующим образом: `pc_new <- {(PC + 4)[31:28], addr, 00}`

Инструкция `jr`, изменяет PC на значение, хранимое в регистре с номером переданным в
`rs`.
