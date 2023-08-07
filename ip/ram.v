/*
*	Double port memory
*/
module ram #(
	parameter WORD_LINE = 256, // address are 8 bits
	parameter BIT_LINE = 8 // byte addressable
) (
	input clk,
	input en, // HIGH when any operation for ram is happening
	
	input [7:0] addr_in_port_1,
	input [7:0] data_in_port_1,
	input r_w_port_1, // 0 for read, 1 for write
	output [7:0] data_out_port_1,
	
	input [7:0] addr_in_port_2,
	input [7:0] data_in_port_2,
	input r_w_port_2, // 0 for read, 1 for write
	output [7:0] data_out_port_2,
);

// TODO : look into how to add flags so vivado compiler infers block ram
reg [256][8] memory;
reg ram_g_clk;

clk_gate clk_gate_inst (
	.clk(clk),
	.en(en),
	.g_clk(ram_g_clk)
);

always @(posedge ram_g_clk) begin 
	if (write_en) begin
		memory[addr_in] <= data_in;
	end else begin
		data_out <= memory[addr_in];
	end
end

endmodule
