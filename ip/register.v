module register #(
	parameter BIT_COUNT = 8
) (
	input clk,
	input write_en,
	input [BIT_COUNT-1:0] reg_in,
	input [BIT_COUNT-1;0] reg_out,	
);

always @(posedge clk) begin
	if (write_en) begin
		reg_out <= reg_in;
	end
end

endmodule
