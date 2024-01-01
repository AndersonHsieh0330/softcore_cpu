`include "../param.vh"

module alu 
#(
	parameter BIT_COUNT = 8
)
(
	input  [BIT_COUNT-1:0] 		 a, // reg_acc or PC
	input  [BIT_COUNT-1:0] 		 b, // reg x0 ~ x6 or immediate value
	input  [BIT_COUNT-1:0] 		 reg_acc,
	input  [BIT_COUNT-1:0] 		 reg_b,
	input  [`ALU_MODE_COUNT-1:0] alu_mode,
	output [BIT_COUNT-1:0] 		 c,
	output [`ALU_FLAG_COUNT-1:0] alu_flags, 
);
wire [3:0] imm;
assign imm = b[3:0];

//--- add, addi
wire [BIT_COUNT-1:0] adder_input;
wire [BIT_COUNT-1:0] adder_output;
// select input signal with enable so we only have to instantiate one adder instance
assign adder_input = (insn_en[`ISA_ADD] & a) | {4'b0, ({4{insn_en[`ISA_ADDI]}} & imm)}; 
adder adder_inst(
	.a(a),
	.b(b), 
	.sum(adder_output),
	.cout(1'bz) // temporary
);

//--- sh, shi
wire [BIT_COUNT-1:0] shift_amount;
wire [BIT_COUNT-1:0] shifter_output;
assign shift_amount = (insn_en[`ISA_SH] & a) | {4'b0, ({4{insn_en[`ISA_SHI]}} & imm)};
shifter shifter_inst (
	.shift_in(a),
	.shift_amount(shift_amount),
	.shift_out(shifter_output)
);

//--- not
wire [BIT_COUNT-1:0] isa_not_result;
assign isa_not_result = ~a;

//--- and
wire [BIT_COUNT-1:0] isa_and_result;
assign isa_and_result = a & b;

//--- or
wire [BIT_COUNT-1:0] isa_or_result;
assign isa_or_result = a | b;

//--- xor, branch flags
wire [BIT_COUNT-1:0] isa_xor_result;
xor_comparator comparator_inst (
	.a(reg_acc), // hard code accumulator to input a for ISA optimization, reuse the adder for pc + 2
	.b(reg_b), // hard code reg_b to input b for ISA optimization, reuse the adder for pc + 2
	.xor_result(isa_xor_result),
	.equal(flags[`ALU_FLAG_EQ]),
	.a_larger(~flags[`ALU_FLAG_GT]) // note that a is reg_acc, so inversed
);

//--- output enable based on insn enable
assign c = 
	(adder_output & {8{alu_mode[`ALU_MODE_ADD]}}) 	  |
	(shifter_output & {8{alu_mode[`ALU_MODE_SHIFT]}}) |
	(isa_not_result & {8{alu_mode[`ALU_MODE_NOT]}})	  |
	(isa_and_result & {8{alu_mode[`ALU_MODE_AND]}})	  |
	(isa_or_result & {8{alu_mode[`ALU_MODE_OR]}})	  |							   |
	(isa_xor_result & {8{alu_mode[`ALU_MODE_XOR]}})	  |
	(a & {8{alu_mode[`ALU_MODE_BYPASS_A]}})			  |
	(b & {8{alu_mode[`ALU_MODE_BYPASS_B]}});

endmodule

