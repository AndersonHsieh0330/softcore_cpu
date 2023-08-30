module bus_control 
(
	input clk,
	input [2:0] reg_num, // encoded, from instruction decoder.
	input [`ISA_INSTRUCTION_COUNT-1:0] instruction_en, // from instruction decoder

	//--- for program counter register
	output reg reg_pc_write_en,
	output reg reg_pc_read_en,

	//--- for register 0 ~ 8
	output reg [7:0] reg_read_en,  
	output reg [7:0] reg_write_en
);

reg [1:0] counter; // in my ISA the longest instruction takes 2 cycles so 2 bits
reg instruction_done; // when current clk cycle is the last cycle of current executing instruction, this signal goes HIGH

always @(*) begin
	//Defaults
	
	reg_pc_write_en <= 1'b0;
	reg_pc_read_en <= 1'b0;
	reg_read_en <= 8'b0;
	reg_write_en <= 8'b0;
	
	instruction_done <= 1'b0;
	counter <= 2'b0;

	if (instruction_en[`ISA_ADD] |
		insturction_en[`ISA_SH]  |
		insturction_en[`ISA_AND] |
		instruction_en[`ISA_OR]  |
		instruction_en[`ISA_XOR] |
		instruction_en[`]) begin
		reg_read_en[reg_num] <= 1'b1;
		reg_write_en[0] <= 1'b1;
		instruction_done <= 1'b1;
	end	

	if (instruction_en[`ISA_CPY] |
		instruction_en[`ISA_LB] |
		instruction_en[]) begin
		reg_read_en[0] <= 1'b1;
		reg_write_en[reg_num] <= 1'b1;
	end

	if (instruction_en[`ISA_CPYPC]) begin
		reg_pc_read_en <= 1'b1;
		reg_write_en[reg_num] <= 1'b1;
	end

	if (instruction_en[`ISA_ADDI] | 
		instruction_en[`ISA_SHI]  | 
		instruction_en[`ISA_NOT]  |
	) begin
		reg_write_en[0] <= 1'b1;
	end

end

endmodule
