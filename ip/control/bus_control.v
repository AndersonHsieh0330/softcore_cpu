module bus_control 
(
	input [2:0] reg_en, // encoded, from instruction decoder
	input [`ISA_INSTRUCTION_COUNT-1:0] instruction_en,
	output [7:0] reg_read_en, 
	output [7:0] reg_write_en
);

always @(*) begin
	
end

endmodule
