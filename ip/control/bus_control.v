module bus_control 
(
	input clk,
	input [2:0] reg_num, // encoded, from instruction decoder.
	input [`ISA_INSTRUCTION_COUNT-1:0] instruction_en, // from instruction decoder

	//--- for program counter register
	output reg reg_pc_write_en,
	output reg reg_pc_read_en,

	//--- for register 0 ~ 8
	output reg [7:0] reg_out_en,  
	output reg [7:0] reg_write_en

	//--- for RAM
	output reg ram_out_en,
	output reg ram_en, // this goes to port 1 of RAM, HIGH when we want RAM to take in address specified at address in port
		
	//--- control signals
	output reg instruction_done; // when current clk cycle is the last cycle of current executing instruction, this signal goes HIGH
);

reg is_second_cycle; // HIGH when current clk cycle is the second clk cycle of an instruction 

always @(posedge clk) begin
	
	// defaults
	reg_pc_write_en <= 1'b0;
	reg_pc_read_en <= 1'b0;
	reg_out_en <= 8'b0;
	reg_write_en <= 8'b0;
	
	instruction_done <= 1'b0;
	counter <= 2'b0;

	// 1 cycle instructions
	if (instruction_en[`ISA_ADD] |
		insturction_en[`ISA_SH]  |
		insturction_en[`ISA_AND] |
		instruction_en[`ISA_OR]  |
		instruction_en[`ISA_XOR] |
		instruction_en[`]) begin
		reg_out_en[reg_num] <= 1'b1;
		reg_write_en[0] <= 1'b1;
		instruction_done <= 1'b1;
	end	

	if (instruction_en[`ISA_CPY]) begin
		reg_out_en[0] <= 1'b1;
		reg_write_en[reg_num] <= 1'b1;
		instruction_done <= 1'b1;
	end

	if (instruction_en[`ISA_CPYPC]) begin
		reg_pc_read_en <= 1'b1;
		reg_write_en[reg_num] <= 1'b1;
		instruction_done <= 1'b1;
	end

	if (instruction_en[`ISA_ADDI] | 
		instruction_en[`ISA_SHI]  | 
		instruction_en[`ISA_NOT]  |
	) begin
		reg_write_en[0] <= 1'b1;
		instruction_done <= 1'b1;
	end

	// 2 cycle instructiosn
	if (is_second_cycle) begin
		if (instruction_en[`ISA_LB]) begin
			reg_write_en[reg_num] <= 1'b1;
			ram_out_en <= 1'b1;
			is_second_cycle <= 1'b0;
		end
	end else begin
		if (instruction_en[`ISA_LB]) begin
			reg_out_en[0] <= 1'b1;
			ram_en <= 1'b1; // register the address at input address port
			is_second_cycle <= 1'b1;
		end
	end

end

endmodule
