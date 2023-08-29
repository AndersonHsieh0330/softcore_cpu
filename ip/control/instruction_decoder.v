module instruction_decoder 
(
	input [7:0] instruction,
	output reg [`ISA_INSTRUCTION_COUNT-1:0] instruction_en,
	output reg [3:0] imm, // the immidiate value from instructions
	output reg [2:0] reg_en // the register specified in instructions
);

wire [3:0] opcode;
wire utility_bit;
wire [2:0] reg_bits;

assign opcode = instructions[7:4];
assign utility_bit = instruction[3];
assign reg_bits = instruction[2:0];

always @(*) begin
	// Defaults
	reg_en = reg_bits;
	imm = 4'b000;
	instruction_en = {`ISA_INSTRUCTION_COUNT{1'b0}};

	case (opcode)
		4'b0000: begin
			instruction_en[`ISA_ADD] = 1'b1;
		end
		4'b0001: begin
			instruction_en[`ISA_ADDI] = 1'b1;
			imm = {utility_bit, reg_bits};
		end
		4'b0010: begin
			instruction_en[`ISA_SH] = 1'b1;
		end
		4'b0011: begin
			instruction_en[`ISA_SHI] = 1'b1;
			imm = {utility_bit, reg_bits};
		end
		4'b0100: begin
			instruction_en[`ISA_NOT] = 1'b1;
		end
		4'b0101: begin
			instruction_en[`ISA_AND] = 1'b1;
		end
		4'b0110: begin
			instruction_en[`ISA_OR] = 1'b1;
		end
		4'b0111: begin
			instruction_en[`ISA_XOR] = 1'b1;
		end
		4'b1000: begin
			if (utility_bit) begin
				instruction_en[`ISA_CPYPC] = 1'b1;
			end else begin
				instruction_en[`ISA_CPY] = 1'b1;
			end
		end
		4'b1001: begin
			instruction_en[`ISA_LB] = 1'b1;
		end
		4'b1010: begin
			instruction_en[`ISA_SB] = 1'b1;
		end
		4'b1011: begin
			instruction_en[`ISA_JMPADR] = 1'b1;
		end
		4'b1100: begin
			instruction_en[`ISA_JMPI] = 1'b1;
			imm = {utility_bit, reg_bits};
		end
		4'b1101: begin
			instruction_en[`ISA_BLT] = 1'b1;
		end
		4'b1110: begin
			instruction_en[`ISA_BGT] = 1'b1;
		end
		4'b1111: begin
			if (utility_bit) begin
				instruction_en[`ISA_BNEQ] = 1'b1;
			end else begin
				instruction_en[`ISA_BEQ] = 1'b1;
			end
		end
		default: // do nothing
		
end

endmodule
