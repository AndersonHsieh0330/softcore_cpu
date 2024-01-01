`default_nettype none
module control (
    input  wire [4:0] opcode,
    output wire [2:0] alu_mode,
    output wire       rf_write_en, // register file write enable
    output wire       rf_write_data_sel, // register file write source select
    output wire       rf_write_addr_sel,
    output wire       alu_a_sel,   // LOW for accumulator, HIGH for PC 
    output wire       alu_b_sel,   // LOW for reg x0 ~ x6, HIGH for immediate value
    output wire       mem_write_en
);

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
        default : begin
            /* jmpi, blt, bge, beq, bneq */
            alu_mode = `ALU_MODE_ADD;
        end
    endcase
end

// add, addi, sh, shi, not, and, or, xor, cpy, cpypc, lb
assign rf_write_en = ~opcode[4] | (opcode[4] & ~opcode[3] & ~opcode[2]);

// lb
assign rf_write_data_sel = opcode[4:1] == 4'b1001; 

assign rf_write_addr_sel = opcode[4] & ~opcode[3] & ~opcode[2];

// jmpi, blt, bge, beq, bneq, and cpypc
assign alu_a_sel = (opcode[4] & opcode[3]) | (opcode == 5'b10001); 

// jmpi, blt, bge, beq, bneq, addi and shi
assign alu_b_sel = (opcode[4] & opcode[3]) | (~opcode[4] & ~opcode[3] & opcode[1]);

// sb
assign mem_write_en = opcode[4:1] == 4'b1010;

endmodule