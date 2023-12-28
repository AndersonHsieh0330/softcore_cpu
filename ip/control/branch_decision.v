`default_nettype none
// this module is used to generate pc_sel signal
module branch_decision (
    input  wire [4:0]                 opcode,
    input  wire [`ALU_FLAG_COUNT-1:0] alu_flags,
    output wire                       pc_sel
);

wire jmpadr_en;
wire jmpi_en;
wire blt_en;
wire bge_en;
wire beq_en;
wire bneq_en;

assign pc_sel = jmpadr_en                                                  |
                jmpi_en                                                    |
                (blt_en & ~alu_flags[`ALU_FLAG_GT])                        |
                (bge_en & alu_flags[`ALU_FLAG_GT]&alu_flags[`ALU_FLAG_EQ]) |
                (beq & alu_flags[`ALU_FALG_EQ])                            |
                (bneq & ~alu_flags[`ALU_FALG_EQ]);

endmodule