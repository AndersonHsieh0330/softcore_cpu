`default_nettype none
module control (
    input [`ISA_INSN_COUNT] insn_en,
    output wire [`ALU_MODE_COUNT-1:0] alu_mode,
    output wire                       pc_sel, // LOW for no jump (PC + 1), HIGH for jump (PC + 2)
    output wire                       acc_write_en, // write enbale for accumulator register
    output wire                       reg_write_en, // write enable for reg x0 ~ x6
    output wire                       alu_a_sel, // LOW for accumulator, HIGH for PC 
    output wire                       alu_b_sel, // LOW for reg x0 ~ x6, HIGH for immediate value
    output wire                       mem_write
);
endmodule