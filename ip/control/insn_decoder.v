`default_nettype none
module insn_decoder 
(
	input 		[7:0] 				  insn,
	output reg  [`ISA_INSN_COUNT-1:0] insn_en,
	output wire [3:0] 				  imm_out, // the immidiate value from insns
	output wire [2:0] 				  reg_out // the register specified in insns
);

wire [3:0] opcode;
wire 	   utility_bit;

assign opcode 	   = insns[7:4];
assign utility_bit = insn[3];
assign reg_out 	   = insn[2:0];
assign imm_out 	   = {imm_out, reg_out};

always @(*) begin
	// Defaults
	insn_en <= {`ISA_INSN_COUNT{1'b0}};

	case (opcode)
		4'b0000: begin
			insn_en[`ISA_ADD] <= 1'b1;
		end
		4'b0001: begin
			insn_en[`ISA_ADDI] <= 1'b1;
		end
		4'b0010: begin
			insn_en[`ISA_SH] <= 1'b1;
		end
		4'b0011: begin
			insn_en[`ISA_SHI] <= 1'b1;
		end
		4'b0100: begin
			insn_en[`ISA_NOT] <= 1'b1;
		end
		4'b0101: begin
			insn_en[`ISA_AND] <= 1'b1;
		end
		4'b0110: begin
			insn_en[`ISA_OR] <= 1'b1;
		end
		4'b0111: begin
			insn_en[`ISA_XOR] <= 1'b1;
		end
		4'b1000: begin
			if (utility_bit) begin
				insn_en[`ISA_CPYPC] <= 1'b1;
			end else begin
				insn_en[`ISA_CPY] <= 1'b1;
			end
		end
		4'b1001: begin
			insn_en[`ISA_LB] <= 1'b1;
		end
		4'b1010: begin
			insn_en[`ISA_SB] <= 1'b1;
		end
		4'b1011: begin
			insn_en[`ISA_JMPADR] <= 1'b1;
		end
		4'b1100: begin
			insn_en[`ISA_JMPI] <= 1'b1;
		end
		4'b1101: begin
			insn_en[`ISA_BLT] <= 1'b1;
		end
		4'b1110: begin
			insn_en[`ISA_BGT] <= 1'b1;
		end
		4'b1111: begin
			if (utility_bit) begin
				insn_en[`ISA_BNEQ] <= 1'b1;
			end else begin
				insn_en[`ISA_BEQ] <= 1'b1;
			end
		end
		default: // do nothing
	endcase
end

endmodule
