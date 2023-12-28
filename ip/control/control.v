`default_nettype none
module control (
    input  wire [4:0] opcode,
    output wire [2:0] alu_mode,
    output wire       rf_write_en, // register file write enable
    output wire       alu_a_sel,   // LOW for accumulator, HIGH for PC 
    output wire       alu_b_sel,   // LOW for reg x0 ~ x6, HIGH for immediate value
    output wire       mem_write_sel,
    output wire       mem_write_en
);

// alu_mode
always @(*) begin
    case(opcode[4:1]) 
        4'b000? : alu_mode = `ALU_MODE_ADD;
        4'b001? : alu_mode = `ALU_MODE_SHIFT;
        4'b0100 : alu_mode = `ALU_MODE_NOT;
        4'b0101 : alu_mode = `ALU_MODE_AND;
        4'b0110 : alu_mode = `ALU_MODE_OR;
        4'b0111 : alu_mode = `ALU_MODE_XOR;
        4'b10?? : begin
            /* cpy, cpypc, lb, sb, jmpadr */
            alu_mode = `ALU_MODE_BYPASS_A;
        end
        4'b1100 : alu_mode = `ALU_MODE_ADD;
        default : begin
            /* blt, bge, beq, bneq */
            alu_mode = `ALU_MODE_ADD;
        end
    endcase
end


endmodule