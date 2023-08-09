//--- ISA
`define ISA_ADD    0
`define ISA_ADDI   1
`define ISA_SH     2
`define ISA_SHI    3
`define ISA_NOT    4
`define ISA_AND    5
`define ISA_OR     6
`define ISA_XOR    7
`define ISA_CPY    8
`define ISA_CPYPC  9
`define ISA_LB     10
`define ISA_SB     11
`define ISA_JMPADR 12
`define ISA_JUMPI  13
`define ISA_BLT    14
`define ISA_BGT    15
`define ISA_BEQ    16
`define ISA_BNEQ   17
`define ISA_INSTRUCTION_COUNT 18

//--- ALU flags
`define ALU_FLAG_EQ    0 // reg_acc == reg_a
`define ALU_FLAG_GT    1 // reg_a > reg_acc
`define ALU_FLAG_COUNT 2
