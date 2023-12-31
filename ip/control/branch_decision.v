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
reg  beq_en;
reg  bneq_en;

assign jmpadr_en = opcode[4:1] == 4'b1011;
assign jmpi_en = opcode[4:1] == 4'b1100;
assign blt_en = opcode[4:1] == 4'b1101;
assign bge_en = opcode[4:1] == 4'b1110;

always @(*) begin
    if (opcode[4:1] == 4'b1111) begin
        beq_en = ~opcode[0];
        bneq_en = opcode[1];
    end
end
assign pc_sel = jmpadr_en                                                  |
                jmpi_en                                                    |
                (blt_en & ~alu_flags[`ALU_FLAG_GT])                        |
                (bge_en & alu_flags[`ALU_FLAG_GT]&alu_flags[`ALU_FLAG_EQ]) |
                (beq & alu_flags[`ALU_FALG_EQ])                            |
                (bneq & ~alu_flags[`ALU_FALG_EQ]);

endmodule