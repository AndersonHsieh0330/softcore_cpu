module xor_comparator_1_bit
(
	input  a,
	input  b,
	input  last_equal, // from higher bit 
	input  last_a_larger, // from higher bit 
	output equal,
	output a_larger,
	output xor_result
);

assign xor_result = a ^ b;
assign equal = ~xor_result & last_equal;
assign a_larger = (last_equal & a & xor_result) | last_a_larger;

endmodule

module xor_comparator
#(
	parameter BIT_COUNT = 8
)
(
	input [BIT_COUNT-1:0] a,
	input [BIT_COUNT-1:0] b,
	output [BIT_COUNT-1:0] xor_result;
	output equal,
	output a_larger,
);

wire [BIT_COUNT-1:0] a_larger;
wire [BIT_COUNT-1:0] equal;

generate
	for (genvar gi = 0 ; gi < BIT_COUNT ; gi = gi + 1) begin
		xor_comparator_1_bit 1b_comparator_inst (
			.a(a[gi]),
			.b(b[gi]),
			.last_equal(gi==(BIT_COUNT-1)?1:equal[gi+1]),
			.equal(equal[gi]),
			.last_a_larger(gi==(BIT_COUNT-1)?0:a_larger[gi+1]),
			.a_larger(a_larger[gi]),
			.xor_result(xor_result[gi])
		);
	end
endgenerate
endmodule

